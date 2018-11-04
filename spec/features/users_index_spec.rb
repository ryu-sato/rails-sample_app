require 'rails_helper'

RSpec.feature "UsersIndex", type: :feature do
  include FeatureLoginHelper

  let!(:admin)     { FactoryBot.create(:user, name: 'michael', admin: true) }
  let!(:non_admin) { FactoryBot.create(:user, name: 'archer',  admin: false) }

  before do
    99.times.each do
      FactoryBot.create(:user, name: Faker::Name.name)
    end
  end

  scenario "index as admin including pagination and delete links" do
    act_as(admin) do
      expect(-> {
        visit users_path
      }).to change { current_path }.to(users_path)

      expect(page).to have_xpath("//div[@class='pagination']")
      first_page_of_users = User.paginate(page: 1)
      first_page_of_users.each do |user|
        # [MEMO] CGI.escapeHTML()でnameをエスケープしてもxpathのマッチにヒットしない
        expect(page).to have_xpath("//a[@href='#{user_path(user)}']")
        if user != admin
          expect(page).to have_xpath("//a[@href='#{user_path(user)}'][text()='delete']")
        end
      end
      expect(-> {
        find_link('delete', href: user_path(non_admin)).click
      }).to change(User, :count).by(-1)
    end
  end

  scenario "index as non-admin" do
    act_as(non_admin) do
      visit users_path
      expect(page).not_to have_xpath("//a[text()='delete']")
    end
  end
end
