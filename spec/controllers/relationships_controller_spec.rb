require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  context 'when user not logged in' do
    context 'if request to create' do
      let(:user) { FactoryBot.create(:user, name: 'michael') }

      subject { post :create, params: { followed_id: user.id } }

      it "should not create" do
        -> { is_expected.to change(Relationship, :count).by(0) }
      end

      it "should redirect to login page" do
        is_expected.to redirect_to(login_url)
      end
    end

    context 'if request to delete' do
      let(:users) { [FactoryBot.create(:user, name: 'michael'), FactoryBot.create(:user, name: 'archer')] }
      let!(:relationship) { FactoryBot.create(:relationship, followed_id: users[0].id, follower_id: users[1].id) }

      subject { delete :destroy, params: { id: relationship } }

      it "should not delete" do
        -> { is_expected.to change(Relationship, :count).by(0) }
      end

      it "should redirect to login page" do
        is_expected.to redirect_to(login_url)
      end
    end
  end
end
