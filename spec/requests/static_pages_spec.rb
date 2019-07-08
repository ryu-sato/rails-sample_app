require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  describe "GET /" do
    it "should get root" do
      get '/'
      expect(response).to have_http_status(200)
      expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
  end

  describe "GET /home" do
    it "should get home" do
      get '/home'
      expect(response).to have_http_status(200)
      expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
  end

  describe "GET /help" do
    it "should get help" do
      get '/help'
      expect(response).to have_http_status(200)
      expect(response.body).to match(/<title>Help | #{base_title}<\/title>/i)
    end
  end

  describe "GET /about" do
    it "should get about" do
      get "/about"
      expect(response).to have_http_status(200)
      expect(response.body).to match(/<title>About | #{base_title}<\/title>/i)
    end
  end

  describe "GET /contact" do
    it "should get contact" do
      get "/contact"
      expect(response).to have_http_status(200)
      expect(response.body).to match(/<title>Contact | #{base_title}<\/title>/i)
    end
  end
end
