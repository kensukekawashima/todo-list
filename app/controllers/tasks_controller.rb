class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]
  before_action :correct_user, only: [:update, :destroy]
  def index
    @tasks = Task.all.order(created_at: "ASC")
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_url }
        format.js
      else
        format.js { render 'error' }
      end
    end
  end

  def update
    # @task = Task.find(params[:id])
      @task.update!(task_params)
      # json: @taskがjavascriptのdataに値を送信
      render json: @task
  end

  def destroy
      @task.destroy
  end

  private

  def set_task
      @task = Task.find(params[:id])
  end

  def correct_user
    if @task.user_id != current_user.id
      flash[:danger] = "YOU ARE NOT CORRECT USER"
      redirect_to root_url
    end
  end

  def task_params
    params.require(:task).permit(:title, :user_id)
  end
end
