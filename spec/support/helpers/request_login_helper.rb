module RequestLoginHelper
  # ログインする
  def log_in_as(user, remember_me = false)
    post login_path,
      params: {
        session: {
          email: user.email,
          password: user.password,
          remember_me: remember_me
        }
      }
  end

  # ログオフする
  def log_out
    delete login_path
  end

  # 特定のユーザでログインした状態でテストを実行する
  def act_as(user, remember_me = false)
    log_in_as(user, remember_me)
    yield
    log_out
  end
end
