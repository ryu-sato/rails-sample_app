module FeatureLoginHelper
  # ログインする
  def log_in_as(user, remember_me = false)
    visit login_path
    within('#session') do
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      if remember_me
        check 'session_remember_me'
      else
        uncheck 'session_remember_me'
      end
    end
    click_button 'Log in'
  end

  # ログオフする
  def log_out
    click_link 'Log out'
  end

  # 特定のユーザでログインした状態でテストを実行する
  def act_as(user, remember_me = false)
    log_in_as(user, remember_me)
    yield
    log_out
  end
end
