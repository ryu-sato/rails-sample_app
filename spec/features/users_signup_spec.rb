require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do
  include FeatureLoginHelper

  before { ActionMailer::Base.deliveries.clear }

  scenario "invalid signup information" do
    visit signup_path
    expect(-> {
      within('#edit_user') do
        fill_in 'user_name', with: ""
        fill_in 'user_email', with: "user@invalid"
        fill_in 'user_password',              with: "foo"
        fill_in 'user_password_confirmation', with: "bar"
      end
      click_button 'Create my account'
    }).to change(User, :count).by(0)
    expect(page).to have_xpath("//div[@id='error_explanation']")
    expect(page).to have_xpath("//div[@class='field_with_errors']")
    expect(page).to have_xpath("//form[@action='/signup']")
  end

  scenario "valid signup information with account activation" do
    visit signup_path
    email = "user@example.com"
    expect(-> {
      within('#edit_user') do
        fill_in 'user_name', with: "Example User"
        fill_in 'user_email', with: email
        fill_in 'user_password',              with: "password"
        fill_in 'user_password_confirmation', with: "password"
      end
      click_button 'Create my account'
    }).to change(User, :count).by(1) && change { ActionMailer::Base.deliveries.size }.by(1)

    # feature スペックから assigns は実行できないためreset_tokenをメールから読み込む
    user = User.find_by(email: email)
    mail = ActionMailer::Base.deliveries.first
    mail.body.encoded.match(/account_activations\/([^\/]+)\/edit/) do |matched|
      user.activation_token = matched[1]
    end
    expect(user.activated?).to be_falsey

    # 有効化されていない状態でログインしてみる
    log_in_as(user)
    expect(page).not_to have_xpath("//a[text()='Log out']")
    # 有効化トークンが不正な場合
    expect(-> {
      visit edit_account_activation_path('invalid token', email: user.email)
    }).to change { current_path }.to(root_path)
    expect(page).not_to have_xpath("//a[text()='Log out']")
    # トークンが正しいがメールアドレスが無効な場合
    expect(-> {
      visit edit_account_activation_path(user.activation_token, email: 'wrong')
    }).not_to change { current_path }
    expect(page).not_to have_xpath("//a[text()='Log out']")
    # 有効化トークンが正しい場合
    expect(-> {
      visit edit_account_activation_path(user.activation_token, email: user.email)
    }).to change { current_path }.to(user_path(user))
    expect(page).to have_xpath("//a[text()='Log out']")
    expect(page).to have_xpath("//div[contains(@class, 'alert-success')]")
  end
end
