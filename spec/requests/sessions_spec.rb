require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  include RequestLoginHelper

  describe "GET /login" do
    it "render new" do
      get '/login'
      expect(response).to have_http_status(200)
    end
  end

  describe 'forwarding url' do
    let(:user) { FactoryBot.create(:user, name: 'michael') }

    it "should store forwarding_url only at first" do
      get '/login'
      redirect_to edit_user_path(user)
      expect(session[:forwarding_url]).not_to eq(edit_user_url(user))

      log_in_as(user)
      expect(session[:forwarding_url]).to be_nil
    end
  end
end
