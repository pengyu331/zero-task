# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :verify_user_access

  def index
  end
end
