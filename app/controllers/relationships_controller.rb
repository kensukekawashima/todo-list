class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = "YOU FAILED TO FOLLOW"
      redirect_to @user
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = "YOU FAILED TO FOLLOW"
      redirect_to @user
    end
  end

  private

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end
