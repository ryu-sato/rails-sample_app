require 'rails_helper'

RSpec.feature "SiteLayout", type: :feature do
  include FeatureLoginHelper

  let(:user) { FactoryBot.create(:user, name: 'michael') }

  scenario "layout links when not logged in" do
    expect(-> {
      visit root_path
    }).to change { current_path }.to(root_path)

    expect(page).to have_xpath("//a[@href='#{root_path}']")
    expect(page).to have_xpath("//a[@href='#{help_path}']")
    expect(page).to have_xpath("//a[@href='#{login_path}']")
    expect(page).to have_xpath("//a[@href='#{about_path}']")
    expect(page).to have_xpath("//a[@href='#{contact_path}']")
    expect(page).to have_xpath("//a[@href='#{signup_path}']")

    visit contact_path
    expect(page).to have_xpath("//title[contains(text(), 'Contact')]", visible: false)

    visit signup_path
    expect(page).to have_xpath("//title[contains(text(), 'Sign up')]", visible: false)
  end

  scenario "layout links when logged in" do
    act_as(user) do
      expect(-> {
        visit root_path
      }).to change { current_path }.to(root_path)

      expect(page).to have_xpath("//a[@href='#{root_path}']")
      expect(page).to have_xpath("//a[@href='#{help_path}']")
      expect(page).to have_xpath("//a[@href='#{about_path}']")
      expect(page).to have_xpath("//a[@href='#{users_path}']")
      expect(page).to have_xpath("//a[@href='#{user_path(user)}']")
      expect(page).to have_xpath("//a[@href='#{edit_user_path(user)}']")
      expect(page).to have_xpath("//a[@href='#{logout_path}']")
      expect(page).to have_xpath("//a[@href='#{contact_path}']")

      visit contact_path
      expect(page).to have_xpath("//title[contains(text(), 'Contact')]", visible: false)

      visit signup_path
      expect(page).to have_xpath("//title[contains(text(), 'Sign up')]", visible: false)
    end
  end
end
