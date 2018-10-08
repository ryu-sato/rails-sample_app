require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 4 errors.'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'bar'
    email = 'foo@valid.domain'
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password: '',
                                              password_confirmation: '' } }

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
