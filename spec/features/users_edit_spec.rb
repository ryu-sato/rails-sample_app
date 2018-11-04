require 'rails_helper'

RSpec.feature "UsersEdit", type: :feature do
  include FeatureLoginHelper

  let(:user) { FactoryBot.create(:user, name: 'michael') }

  scenario "unsuccessful edit" do
    act_as(user) do
      expect(-> {
        visit edit_user_path(user)
      }).to change { current_path }.to(edit_user_path(user))

      within "#edit_user" do
        fill_in 'user_name',  with: ""
        fill_in 'user_email', with: "foo@invalid"
        fill_in 'user_password',              with: "foo"
        fill_in 'user_password_confirmation', with: "bar"
      end
      click_button 'Save changes'

      expect(page).to have_xpath("//div[contains(@class, 'alert-danger')][contains(text(), 'The form contains 4 errors.')]")
    end
  end
  
  scenario "successful edit with friendly forwarding" do
    visit edit_user_path(user)
    expect(-> {
      within('#session') do
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
      end
      click_button 'Log in'
    }).to change { current_path }.to(edit_user_path(user))

    name = 'bar'
    email = 'foo@valid.domain'
    expect(-> {
      within('#edit_user') do
        fill_in 'user_name', with: name
        fill_in 'user_email', with: email
        fill_in 'user_password',              with: ""
        fill_in 'user_password_confirmation', with: ""
      end
      click_button 'Save changes'
    }).to change { current_path }.to(user_path(user))

    expect(page).not_to have_xpath("//div[contains(@class, 'alert-danger')]")
    user.reload
    expect(user.name).to eq(name)
    expect(user.email).to eq(email)
  end
end
