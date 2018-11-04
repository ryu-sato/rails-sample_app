require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include LoginHelper

  let(:user) { FactoryBot.create(:user, name: 'michael') }

  it "should get new" do
    get :new
    expect(response.status).to eq(200)
  end

  it "should store forwarding_url only at first" do
    redirect_to edit_user_path(user)
    expect(session[:forwarding_url]).not_to eq(edit_user_url(user))
    log_in_as(user)
    expect(session[:forwarding_url]).to be_nil
  end
end
