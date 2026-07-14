# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :verify_user_access

  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(5)
    @new_task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_tasks_path(current_user), notice: "Task created." }
      end
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence

      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash_messages", partial: "shared/flash") }
        format.html { render :index, status: :unprocessable_content }
      end
    end
  end

  private

  def verify_user_access
    unless current_user.id.to_s == params[:user_id]
      redirect_to root_path, alert: "Access Denied: You are attempting to view an invalid resource."
    end
  end

  def task_params
    params.expect(task: [:description])
  end
end
