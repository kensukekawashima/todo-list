class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    comment = Comment.new(comment_params)
    puts "#{comment}"
    task = Task.find_by(id: comment.task_id)
    if comment.user_id == current_user.id
      comment.save
      redirect_to task_path(task)
    else
      flash[:danger] = "YOU DON'T HAVE THE RIGHT"
      redirect_to root_url
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user_id == current_user.id
      comment.destroy
      redirect_to task_path(comment.task_id)
    else
      flash[:danger] = "YOU DON'T HAVE THE RIGHT"
      redirect_to root_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :task_id)
  end

end
