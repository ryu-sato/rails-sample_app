require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  include RequestLoginHelper

  describe "POST /relationships" do
    context 'when user not logged in' do
      context 'if request to create' do
        let(:user) { FactoryBot.create(:user, name: 'michael') }
  
        subject { post relationships_path, params: { followed_id: user.id } }

        it "is expected to not create" do
          -> { is_expected.to change(Relationship, :count).by(0) }
        end

        it "is expected to redirect to login page" do
          is_expected.to redirect_to(login_url)
        end
      end
    end
  end

  describe 'DELETE /relationships' do
    context 'when user not logged in' do
      context 'if request to delete' do
        let(:users) { [FactoryBot.create(:user, name: 'michael'), FactoryBot.create(:user, name: 'archer')] }
        let!(:relationship) { FactoryBot.create(:relationship, followed_id: users[0].id, follower_id: users[1].id) }
  
        subject { delete relationship_path(relationship) }

        it "should not delete" do
          -> { is_expected.to change(Relationship, :count).by(0) }
        end

        it "should redirect to login page" do
          is_expected.to redirect_to(login_url)
        end
      end
    end
  end
end
