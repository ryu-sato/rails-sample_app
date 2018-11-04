require 'rails_helper'

RSpec.feature "Following", type: :feature do
  let(:user) { FactoryBot.create(:user, name: 'michael') }
  let(:other) { FactoryBot.create(:user, name: 'archer') }

  # user,otherで相互フォローし、otherに適当なマイクロポストを30件追加
  before do
    user.follow(other)
    other.follow(user)
    30.times.each do
      other.microposts.create(content: Faker::Lorem.sentence(5))
    end
  end

  # userでログインする
  before do
    visit login_path
    within('#session') do
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
    end
    click_button 'Log in'
  end

  scenario "following page" do
    visit following_user_path(user)
    expect(user.following).not_to be_empty
    expect(page).to have_content(user.following.count.to_s)
    user.following.each do |user|
      expect(page).to have_xpath("//a[@href='#{user_path(user)}']")
    end
  end

  scenario "followers page" do
    visit followers_user_path(user)
    expect(user.followers).not_to be_empty
    expect(page).to have_content(user.followers.count.to_s)
    user.followers.each do |user|
      expect(page).to have_xpath("//a[@href='#{user_path(user)}']")
    end
  end

  context 'when user request follow a user by standard way' do
    subject { post relationships_path, params: { followed_id: other.id  } }

    it "should follow successfully" do
      -> { is_expected.to change { user.following.count }.by(1) }
    end
  end

  context 'when user request follow a user with AJAX' do
    subject { post relationships_path, xhr: true, params: { followed_id: other.id  } }

    it "should follow successfully" do
      -> { is_expected.to change { user.following.count }.by(1) }
    end
  end

  context 'if use request unfollow a user' do
    let(:relationship) { user.active_relationships.find_by(followed_id: other.id) }

    context 'by standard way' do
      subject { delete relationship_path(relationship) }

      it "should unfollow successfully" do
        -> { is_expected.to change { user.following.count }.by(-1) }
      end
    end

    context 'with AJAX' do
      subject { delete relationship_path(relationship), xhr: true }

      it "should unfollow successfully" do
        -> { is_expected.to change { user.following.count }.by(-1) }
      end
    end
  end

  scenario "feed on Home page" do
    visit root_path
    expect(page).to have_content(user.following.count.to_s)
    expect(page).to have_content(user.followers.count.to_s)
    user.feed.paginate(page: 1).each do |micropost|
      expect(page).to have_content(CGI.escapeHTML(micropost.content))
    end
  end
end
