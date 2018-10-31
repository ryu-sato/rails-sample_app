require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  include LoginHelper

  it "should redirect create when not logged in" do
    expect(-> {
      post :create, params: { micropost: { content: 'Lorem ipsum' }}
    }).to change { Micropost.count }.by(0) & redirect_to(login_url)
  end

  it "should redirect destroy when not logged in" do
    user = FactoryBot.create(:user)
    micropost = user.microposts.create(content: 'hoge')
    expect(-> {
      delete :destroy, params: { id: micropost }
    }).to change { Micropost.count }.by(0).and redirect_to(login_url)
  end

  it "should redirect destroy for wrong micropost" do
    michael = FactoryBot.create(:user, name: 'michael')
    other = FactoryBot.create(:user, name: 'other')
    log_in_as(michael)
    micropost = other.microposts.create(content: 'ants')
    expect(-> {
      delete :destroy, params: { id: micropost }
    }).to change { Micropost.count }.by(0).and redirect_to(root_url)
  end
end
