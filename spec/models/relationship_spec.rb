require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user1)        { FactoryBot.create(:user, name: 'user1') }
  let(:user2)        { FactoryBot.create(:user, name: 'user2') }
  let(:relationship) { FactoryBot.create(:relationship, follower_id: user1.id,
                                         followed_id: user2.id)}

  it "should be valid" do
    expect(relationship).to be_valid
  end

  it "should require a follower_id" do
    relationship.follower_id = nil
    expect(relationship).to_not be_valid
  end

  it "should require a followed_id" do
    relationship.followed_id = nil
    expect(relationship).to_not be_valid
  end
end
