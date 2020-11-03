module SessionsHelper

  # ログイン用
  def log_in(user)
    session[:user_id] = user.id
  end

  # 別のページでユーザーIDを取り出すため
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
      # sessionがなく、user_idがcookiesに保存してあったらuser_idに代入
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      # user.idとuserの記憶ダイジェストがDBにあるものと一致したら
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
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

  # 永続的セッションを破壊する
  def forget(user)
    user.forget
    cookies.delete(:user_id) # cookiesに保存してあるuser_idを削除
    cookies.delete(:remember_token) # cookiesに保存してあるremember_tokenを削除
  end

  # ログアウト用
  def logout
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 永続的セッションを作成
  def remember(user)
    user.remember #Userモデルで定義したrememberメソッド。記憶トークンを作成、ハッシュ化してDBに保存
    cookies.permanent.signed[:user_id] = user.id #ユーザーIDを暗号化(signed[:?] ?は保存したいもの)してcookieに保存
    cookies.permanent[:remember_token] = user.remember_token #記憶トークンをcookieに保存
  end
end
