class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]
  def index
    @tasks = Task.all.order(created_at: "ASC")
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to root_url
  end

  def update
    # @task = Task.find(params[:id])
    @task.update!(task_params)
    # json: @taskがjavascriptのdataに値を送信
    render json: @task
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to root_url
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title)
  end
end
