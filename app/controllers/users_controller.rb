class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show,:edit,:update,:destroy,:followings,:followers]
  before_action :correct_user, only: [:edit,:update,:destroy]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.page(params[:page]).per(10)
    @task = Task.new
  end

  def new
    @user = User.new
  end

  def create
    # インスタンス変数にする必要がある。理由は、エラ〜メッセージを表示する前は必ずこのcreate actionを通るため
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:succes] = "SIGNED UP"
      redirect_to @user
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
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "THANK YOU FOR USING THIS APP"
    redirect_to root_url
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest)
  end

  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      flash[:danger] = "YOU DO NOT HAVE THE RIGHT"
      redirect_to root_url
    end
  end

end
