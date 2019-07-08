require 'rails_helper'

RSpec.describe "Users", type: :request do
  include RequestLoginHelper

  let!(:user)       { FactoryBot.create(:user, name: 'michael') }
  let!(:other_user) { FactoryBot.create(:user, name: 'archer') }

  it "should get new" do
    get new_user_path
    expect(response).to have_http_status(200)
  end

  context "when logged in" do
    context "if request to edit other use" do
      before { log_in_as(other_user) }
      subject { get edit_user_path(user) }

      it "should redirect to root" do
        expect(flash[:success]).to be_nil
        is_expected.to redirect_to(root_url)
      end
    end

    context "if request to update other user" do
      before { log_in_as(other_user) }
      subject { patch user_path(user), params: { user: { name: user.name,
                                                         email: user.email } } }

      it "should redirect to root" do
        expect(flash[:success]).to be_nil
        is_expected.to redirect_to(root_url)
      end
    end
  end

  context "when not logged in" do
    context "if request to index" do
      before { get users_path }

      it "should redirect index" do
        is_expected.to redirect_to(login_url)
      end
    end

    context "if request delete" do
      subject { delete user_path(user) }

      it 'cannot delete and redirect to login page' do
        # change マッチャを使うためブロック文にする必要がある
        -> { is_expected.to change(User, :count).by(0) }
        is_expected.to redirect_to(login_url)
      end
    end

    context "if request following" do
      subject { get following_user_path(user) }

      it "should redirect to login page" do
        is_expected.to redirect_to(login_url)
      end
    end

    context "if request followers" do
      subject { get followers_user_path(user) }

      it "should redirect to login page" do
        is_expected.to redirect_to(login_url)
      end
    end
  end

  it "should not allow the admin attribute to be edited via the web" do
    log_in_as(other_user)
    expect(other_user.admin?).to be_falsey
    patch user_path(other_user), params: { user: { password:              '',
                                                   password_confirmation: '',
                                                   admin: true } }
    expect(other_user.admin?).to be_falsey
  end

  context "when logged in as a non-admin" do
    before { log_in_as(other_user) }

    context "if request to destroy" do
      subject { delete user_path(user) }

      it 'should redirect to root' do
        # change マッチャを使うためブロック文にする必要がある
        -> { is_expected.to change(User, :count).by(0) }
        is_expected.to redirect_to(root_url)
      end
    end
  end
end
