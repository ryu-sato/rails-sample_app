require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include LoginHelper

  let!(:user)       { FactoryBot.create(:user, name: 'michael') }
  let!(:other_user) { FactoryBot.create(:user, name: 'archer') }

  it "should get new" do
    get :new
    expect(response.status).to eq(200)
  end

  context "when logged in" do
    context "if request to edit other use" do
      before { log_in_as(other_user) }
      subject { get :edit, params: { id: user.id } }

      it "should redirect to root" do
        expect(flash[:success]).to be_nil
        is_expected.to redirect_to(root_url)
      end
    end

    context "if request to update other user" do
      before { log_in_as(other_user) }
      subject { patch :update, params: { id: user.id, user: { name: user.name,
                                                              email: user.email } } }

      it "should redirect to root" do
        expect(flash[:success]).to be_nil
        is_expected.to redirect_to(root_url)
      end
    end
  end

  context "when not logged in" do
    context "if request to index" do
      before { get :index }

      it "should redirect index" do
        is_expected.to redirect_to(login_url)
      end
    end

    context "if request delete" do
      subject { delete :destroy, params: { id: user.id } }

      it 'cannot delete and redirect to login page' do
        # change マッチャを使うためブロック文にする必要がある
        -> { is_expected.to change(User, :count).by(0) }
        is_expected.to redirect_to(login_url)
      end
    end

    context "if request following" do
      subject { get :following, params: { id: user.id } }
      it "should redirect to login page" do
        is_expected.to redirect_to(login_url)
      end
    end

    context "if request followers" do
      subject { get :followers, params: { id: user.id } }
      it "should redirect to login page" do
        is_expected.to redirect_to(login_url)
      end
    end
  end

  it "should not allow the admin attribute to be edited via the web" do
    log_in_as(other_user)
    expect(other_user.admin?).to be_falsey
    patch :update, params: { id: other_user.id,
                             user: { password:              '',
                                     password_confirmation: '',
                                     admin: true } }
    expect(other_user.admin?).to be_falsey
  end

  context "when logged in as a non-admin" do
    before { log_in_as(other_user) }

    context "if request to destroy" do
      subject { delete :destroy, params: { id: user.id } }

      it 'should redirect to root' do
        # change マッチャを使うためブロック文にする必要がある
        -> { is_expected.to change(User, :count).by(0) }
        is_expected.to redirect_to(root_url)
      end
    end
  end
end
