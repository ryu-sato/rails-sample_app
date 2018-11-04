require 'rails_helper'

RSpec.feature "PasswordResets", type: :feature do
  let(:user) { FactoryBot.create(:user, name: 'michael') }

  before { ActionMailer::Base.deliveries.clear }
  
  scenario "password resets" do
    visit new_password_reset_path

    # メールアドレスが無効
    within '#password_reset' do
      fill_in 'password_reset_email', with: ''
    end
    click_button 'Submit'
    expect(page).to have_xpath("//div[contains(@class, 'alert')]")

    # メールアドレスが有効
    expect(-> {
    within '#password_reset' do
      fill_in 'password_reset_email', with: user.email
    end
    click_button 'Submit'
    }).to change { current_path }.to(root_path) && change { ActionMailer::Base.deliveries.size }.by(1)
    expect(user.reset_digest).not_to eq(user.reload.reset_digest)
    expect(page).to have_xpath("//div[contains(@class, 'alert')]")

    # パスワード再設定フォームのテスト
    # feature スペックから assigns は実行できないためreset_tokenをメールから読み込む
    mail = ActionMailer::Base.deliveries.first
    mail.body.encoded.match(/password_resets\/([^\/]+)\/edit/) do |matched|
      user.reset_token = matched[1]
    end
    # メールアドレスが無効
    expect(-> {
      visit edit_password_reset_path(user.reset_token, email: "")
    }).not_to change { current_path }

    # 無効なユーザー
    user.toggle!(:activated)
    expect(-> {
      visit edit_password_reset_path(user.reset_token, email: user.email)
    }).not_to change { current_path }
    user.toggle!(:activated)

    # メールアドレスが有効で、トークンが無効
    expect(-> {
      visit edit_password_reset_path('wrong token', email: user.email)
    }).not_to change { current_path }

    # メールアドレスもトークンも有効
    expect(-> {
      visit edit_password_reset_path(user.reset_token, email: user.email)
    }).to change { current_path }.to(edit_password_reset_path(user.reset_token))
    expect(page).to have_xpath("//input[@name='email' and @type='hidden' and @value='#{user.email}']", visible: false)

    # パスワードとパスワード確認が不一致
    within '#edit_password_reset' do
      fill_in 'user_password',              with: 'foobaz'
      fill_in 'user_password_confirmation', with: 'barquux'
    end
    click_button 'Update password'
    expect(page).to have_xpath("//div[@id='error_explanation']")

    # パスワードが空
    within '#edit_password_reset' do
      fill_in 'user_password',              with: ''
      fill_in 'user_password_confirmation', with: ''
    end
    click_button 'Update password'
    expect(page).to have_xpath("//div[@id='error_explanation']")

    # 有効なパスワードとパスワード確認
    expect(-> {
      within '#edit_password_reset' do
        fill_in 'user_password',              with: 'foobaz'
        fill_in 'user_password_confirmation', with: 'foobaz'
      end
      click_button 'Update password'
    }).to change { current_path }.to(user_path(user))
    expect(page).to have_xpath("//div[contains(@class, 'alert')]")
    expect(page).to have_xpath("//a[text()='Log out']")
    expect(user.reload.reset_digest).to be_nil
  end

  scenario "expired token" do
    visit new_password_reset_path
    within '#password_reset' do
      fill_in 'password_reset_email', with: user.email
    end
    click_button 'Submit'

    mail = ActionMailer::Base.deliveries.first
    mail.body.encoded.match(/password_resets\/([^\/]+)\/edit/) do |matched|
      user.reset_token = matched[1]
    end
    user.update_attribute(:reset_sent_at, 3.hours.ago)
    visit edit_password_reset_path(user.reset_token, email: user.email)
    expect(page).to have_content(/Password reset has expired./i)
  end
end
