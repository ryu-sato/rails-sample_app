require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  include RequestLoginHelper

  describe "POST /microposts" do
    context 'when not logged in' do
      it "should redirect create" do
        expect(-> {
          post microposts_path, params: { micropost: { content: 'Lorem ipsum' }}
        }).to change { Micropost.count }.by(0).and redirect_to(login_url)
      end
    end
  end

  describe "DELETE /microposts" do
    context 'when not logged in' do
      it "should redirect destroy" do
        user = FactoryBot.create(:user)
        micropost = user.microposts.create(content: 'hoge')
        expect(-> {
          delete micropost_path(micropost)
        }).to change { Micropost.count }.by(0).and redirect_to(login_url)
      end
    end
  end

  describe 'DELETE /microposts' do
    context 'if not own micropost' do
      it "should redirect destroy" do
        michael = FactoryBot.create(:user, name: 'michael')
        other = FactoryBot.create(:user, name: 'other')
        log_in_as(michael)
        micropost = other.microposts.create(content: 'ants')
        expect(-> {
          delete micropost_path(micropost)
        }).to change { Micropost.count }.by(0).and redirect_to(root_url)
      end
    end
  end
end
