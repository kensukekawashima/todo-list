class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash.now[:success] = "LOGGED IN"
      redirect_to user
    else
      flash.now[:danger] = "SOMETHING WRONG"
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = "LOGGED OUT"
    redirect_to root_url
  end
end
