require 'rails_helper'

RSpec.feature "UsersLogin", type: :feature do
  include FeatureLoginHelper

  let(:user) { FactoryBot.create(:user, name: 'michael', password: 'password') }

  scenario "login with invalid information" do
    expect(-> {
      visit login_path
    }).to change { current_path }.to(login_path)

    within('#session') do
      fill_in 'session_email', with: ""
      fill_in 'session_password', with: ""
    end
    click_button 'Log in'
    expect(page).to have_xpath("//div[contains(@class, 'alert-danger')]")

    visit root_path
    expect(page).not_to have_xpath("//div[contains(@class, 'alert-danger')]")
  end

  scenario "login with valid information followed by logout" do
    visit login_path
    expect(-> {
      within('#session') do
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: 'password'
      end
      click_button 'Log in'
    }).to change { current_path }.to(user_path(user))

    expect(page).not_to have_xpath("//a[@href='#{login_path}']")
    expect(page).to have_xpath("//a[@href='#{logout_path}']")
    expect(page).to have_xpath("//a[@href='#{user_path(user)}']")

    expect(-> {
      log_out
    }).to change { current_path }.to(root_path)

    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    expect(page).to have_xpath("//a[@href='#{login_path}']")
    expect(page).not_to have_xpath("//a[@href='#{logout_path}']")
    expect(page).not_to have_xpath("//a[@href='#{user_path(user)}']")
  end

  scenario "login with remembering" do
    act_as(user, remember_me: true) do
      expect(page.driver.cookies['remember_token']).not_to be_empty
    end
  end

  scenario "login without remembering" do
    # クッキーを保存してログイン
    act_as(user, remember_me: true) do
    end
    # クッキーを削除してログイン
    act_as(user, remember_me: false) do
      expect(page.driver.cookies['remember_token']).to be_empty
    end
  end
end
