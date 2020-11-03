class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]
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
    if @task.user_id == current_user.id
      @task.update!(task_params)
      # json: @taskがjavascriptのdataに値を送信
      render json: @task
    else
      flash[:danger] = "YOU ARE NOT CORRECT USER"
      redirect_to root_url
    end
  end

  def destroy
    if @task.user_id == current_user.id
      @task.destroy
    else
      flash[:danger] = "YOU ARE NOT CORRECT USER"
      redirect_to root_url
    end
  end

  private

  def set_task
      @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :user_id)
  end
end
