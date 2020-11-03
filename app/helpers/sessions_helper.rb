module SessionsHelper

  # ログイン用
  def log_in(user)
    session[:user_id] = user.id
  end

  # 別のページでユーザーIDを取り出すため
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # 本人check
  def current_user?(user)
    user == current_user
  end

  # ログインしているか
  def logged_in?
    !current_user.nil?
  end

  # ログアウト用
  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
