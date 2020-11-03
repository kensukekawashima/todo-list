class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash.now[:success] = "LOGGED IN"
      redirect_to user
    else
      flash.now[:danger] = "SOMETHING WRONG"
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = "LOGGED OUT"
    redirect_to root_url
  end
end
