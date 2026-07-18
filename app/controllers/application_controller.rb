# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  private

  def verify_user_access
    unless current_user.id.to_s == params[:user_id]
      redirect_to root_path, alert: "Access Denied: You are attempting to view an invalid resource."
    end
  end
end
