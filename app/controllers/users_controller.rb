class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show,:edit,:update,:destroy]
  before_action :correct_user, only: [:edit,:update,:destroy]

  def index
    @users = User.all.order(created_at: "DESC")
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order(created_at: "ASC")
    @task = Task.new
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      log_in user
      flash[:succes] = "SIGNED UP"
      redirect_to user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render @user
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "THANK YOU FOR USING THIS APP"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] ="SHOULD LOG IN"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      flash[:danger] = "YOU DO NOT HAVE THE RIGHT"
      redirect_to root_url
    end
  end

end
