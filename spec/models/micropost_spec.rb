require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user)      { FactoryBot.create(:user) }
  let(:micropost) { user.microposts.create(content: 'Lorem ipsum') }

  it "should be valid" do
    expect(micropost).to be_valid
  end

  it "user id should be present" do
    micropost.user_id = nil
    expect(micropost).to_not be_valid
  end

  it "content should be present" do
    micropost.content = "  "
    expect(micropost).to_not be_valid
  end

  it "content should be at most 140 characters" do
    micropost.content = "a" * 141
    expect(micropost).to_not be_valid
  end

  it "order should be most recent first" do
    [2.hours.ago, 3.years.ago, 1.week.ago].each do |time|
      user.microposts.create(content: time.to_s, created_at: time)
    end
    resent_micropost = user.microposts.create(content: 'Lorem ipsum', created_at: Time.zone.now)
    expect(Micropost.first).to eq(resent_micropost)
  end
end
