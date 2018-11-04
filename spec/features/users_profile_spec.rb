require 'rails_helper'

RSpec.feature "UsersProfile", type: :feature do
  include ApplicationHelper

  let!(:user) { FactoryBot.create(:user, name: 'michael') }

  before do
    60.times.each do
      user.microposts.create!(content: Faker::Lorem.sentence(5))
    end
  end

  scenario "profile display" do
    expect(-> {
      visit user_path(user)
    }).to change { current_path }.to(user_path(user))
    expect(page).to have_xpath("//title[contains(text(), '#{full_title(user.name)}')]", visible: false)
    expect(page).to have_content(user.name)
    expect(page).to have_xpath("//h1/img[@class='gravatar']")
    expect(page).to have_content(user.microposts.count.to_s)
    expect(page).to have_xpath("//div[@class='pagination']")
    user.microposts.paginate(page: 1).each do |micropost|
      expect(page).to have_content(micropost.content)
    end
    expect(page).to have_content(user.following.count.to_s)
    expect(page).to have_content(user.followers.count.to_s)
  end
end
