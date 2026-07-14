# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :verify_user_access

  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(5)
    @new_task = current_user.tasks.build
  end

  private

  def verify_user_access
    unless current_user.id.to_s == params[:user_id]
      redirect_to root_path, alert: "Access Denied: You are attempting to view an invalid resource."
    end
  end
end
