# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/tasks", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: "xavi@github.com") }

  describe "GET #index" do
    context "when not signed in" do
      it "can't view the task list" do
        get user_tasks_path(user)

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when already signed in" do
      before do
        sign_in user
      end

      it "can view the task list" do
        create_list(:task, 5, user: user)
        get user_tasks_path(user)

        expect(response).to have_http_status(:success)
        expect(response.body).to include("Initialize cyberpunk todo item")
      end

      it "can't view other user's tasks" do
        get user_tasks_path(other_user)

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to match(/Access Denied/)
      end
    end
  end
end
