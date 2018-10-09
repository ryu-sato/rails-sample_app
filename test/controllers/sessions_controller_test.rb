require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should store forwarding_url only at first" do
    get edit_user_path(@user)
    assert_equal session[:forwarding_url], url_for([:edit, @user])
    log_in_as(@user)
    assert session[:forwarding_url].blank?
  end
end
