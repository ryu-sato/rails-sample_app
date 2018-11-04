require 'rails_helper'

RSpec.feature "MicropostsInterface", type: :feature do
  include FeatureLoginHelper

  let(:user)              { FactoryBot.create(:user, name: 'michael') }
  let(:archer)            { FactoryBot.create(:user, name: 'archer')}
  let(:has_no_posts_user) { FactoryBot.create(:user, name: 'malory') }

  before do
    user.follow(archer)
    archer.follow(user)
    30.times.each do
      user.microposts.create(content: Faker::Lorem.sentence(5))
    end
    30.times.each do
      archer.microposts.create(content: Faker::Lorem.sentence(5))
    end
  end

  scenario "micropost interface" do
    act_as(user) do
      visit root_path
      expect(page).to have_xpath("//div[@class='pagination']")

      # 無効な送信
      expect(-> {
        within '#micropost' do
          fill_in 'micropost_content', with: ''
        end
        click_button 'Post'
      }).to change(Micropost, :count).by(0)
      expect(page).to have_xpath("//div[@id='error_explanation']")

      # 有効な送信
      content = 'This micropost really ties the room toghether'
      picture = file_fixture("rails.png")
      expect(-> {
        within '#micropost' do
          fill_in 'micropost_content', with: content
          attach_file 'micropost_picture', picture
        end
        click_button 'Post'
      }).to change(Micropost, :count).by(1) && change { current_path }.to(root_path)
      expect(user.microposts.first.picture?).to be_truthy
      expect(page).to have_content(content)

      # 投稿を削除する
      expect(page).to have_xpath("//a[text()='delete']")
      first_micropost = user.microposts.paginate(page: 1).first
      expect(-> {
        click_link('delete')
      }).to change(Micropost, :count).by(-1)

      # 違うユーザのプロフィールにアクセス(削除リンクがないことを確認)
      visit user_path(archer)
      expect(page).not_to have_xpath("//a[text()='delete']")
    end
  end

  scenario "micropost sidebar count" do
    act_as(user) do
      visit root_path
      count_of_microposts = "#{user.microposts.size} microposts"
      expect(page).to have_content(count_of_microposts)
    end

    # まだマイクロポストを投稿していないユーザー
    act_as(has_no_posts_user) do
      visit root_path
      expect(page).to have_content("0 microposts")

      has_no_posts_user.microposts.create!(content: "A micropost")
      visit root_path
      expect(page).to have_content("1 micropost")
    end
  end
end
