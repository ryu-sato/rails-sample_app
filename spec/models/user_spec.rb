require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user, name: "Example User", email: "user@example.com",
                                 password: "foobar", password_confirmation: "foobar") }

  it "should be valid" do
    expect(user).to be_valid
  end

  it "name should be present" do
    user.name = "     "
    expect(user).to_not be_valid
  end

  it "email should be present" do
    user.email = ""
    expect(user).to_not be_valid
  end

  it "name should not be too long" do
    user.name = 'a' * 51
    expect(user).to_not be_valid
  end

  it "email should not be too long" do
    domain_part = '@example.com'
    user.name = 'a' * (256 - domain_part.length) + domain_part
    expect(user).to_not be_valid
  end

  it "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foot.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "email addresses should be unique" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).to_not be_valid
  end

  it "email address should be save as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(user.email).to eq(mixed_case_email.downcase)
  end

  it "password should be present (nonblank)" do
    user.password = user.password_confirmation = ' ' * 6
    expect(user).to_not be_valid
  end

  it "password should have a minimum length" do
    user.password = user.password_confirmation = 'a' * 5
    expect(user).to_not be_valid
  end

  it "authenticated? should return false for a user with nil digest" do
    expect(user.authenticated?(:remember, '')).to be_falsy
  end

  it "associated microposts should be destroyed" do
    user.save
    user.microposts.create!(content: "Lorem ipsum")
    expect { user.destroy }.to change { Micropost.count }.by(-1)
  end

  it "should follow and unfollow a user" do
    michael = FactoryBot.create(:user, name: 7)
    archer = FactoryBot.create(:user, name: 'archer')
    expect(michael.following?(archer)).to be_falsy
    michael.follow(archer)
    expect(michael.following?(archer)).to be_truthy
    expect(archer.followers).to include(michael)
    michael.unfollow(archer)
    expect(michael.following?(archer)).to be_falsy
  end

  it "feed should have the right posts" do
    michael = FactoryBot.create(:user, name: 'michael')
    archer = FactoryBot.create(:user, name: 'archer')
    lana = FactoryBot.create(:user, name: 'lana')
    # フォローしているユーザーの投稿を確認
    lana.microposts.each do |post_following|
      expect(michael.feed).to include(post_following)
    end
    # 自分自身の投稿を確認
    michael.microposts.each do |post_self|
      expect(michael.feed).to include(post_self)
    end
    # フォローしていないユーザーの投稿を確認
    archer.microposts.each do |post_unfollowed|
      expect(michael.feed).to_not include(post_unfollowed)
    end
  end
end
