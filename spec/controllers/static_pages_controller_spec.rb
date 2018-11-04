require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views

  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  it "should get root" do
    get :home
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>#{base_title}<\/title>/i)
  end

  it "should get home" do
    get :home
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>#{base_title}<\/title>/i)
  end

  it "should get help" do
    get :help
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>Help | #{base_title}<\/title>/i)
  end

  it "should get about" do
    get :about
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>About | #{base_title}<\/title>/i)
  end

  it "should get contact" do
    get :contact
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>Contact | #{base_title}<\/title>/i)
  end
end
