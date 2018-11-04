module FeatureLoginHelper
  # ログインする
  def log_in_as(user)
    visit login_path
    within('#session') do
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
    end
    click_button 'Log in'
  end

  # ログオフする
  def log_out
    click_link 'Log out'
  end

  # 特定のユーザでログインした状態でテストを実行する
  def act_as(user)
    log_in_as(user)
    yield
    log_out
  end
end
