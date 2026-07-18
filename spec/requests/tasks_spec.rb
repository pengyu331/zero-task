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

  describe "POST #create" do
    before do
      sign_in user
    end

    context "with valid params" do
      let(:valid_params) { {task: {description: "Learning Ruby"}} }

      subject { post user_tasks_path(user), params: valid_params, as: :turbo_stream }

      it "creates the task successfully" do
        expect { subject }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:success)
        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response.body).to include('turbo-stream action="prepend" target="tasks_list"')
        expect(response.body).to include("Learning Ruby")
      end
    end

    context "with invalid params" do
      let(:invalid_params) { {task: {description: "A" * 141}} }

      subject { post user_tasks_path(user), params: invalid_params, as: :turbo_stream }

      it "does not create the task" do
        expect { subject }.not_to change(Task, :count)

        expect(response.body).to include('turbo-stream action="replace" target="flash_messages"')
      end
    end

    context "with invalid params2" do
      let(:invalid_params) { {task: {description: ""}} }

      subject { post user_tasks_path(user), params: invalid_params, as: :turbo_stream }

      it "does not create the task" do
        expect { subject }.not_to change(Task, :count)

        expect(response.body).to include('turbo-stream action="replace" target="flash_messages"')
      end
    end
  end

  describe "PUT #update" do
    let(:task) { create(:task, user: user) }

    before do
      sign_in user
    end

    context "with valid params" do
      it "updates the task successfully" do
        put user_task_path(user, task), params: {task: {description: "Play chess with friends"}}

        expect(task.reload.description).to eq("Play chess with friends")
        expect(response).to redirect_to(user_tasks_path(user))
        expect(flash[:notice]).to match(/Task updated/)
      end

      it "toggle the task state successfully" do
        put user_task_path(user, task), params: { task: { state: "completed"} }, as: :turbo_stream

        expect(task.reload.state).to eq("completed")

        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response.body).to include("turbo-stream action=\"replace\" target=\"task_#{task.id}\"")

        expect(response.body).to include("line-through")
      end
    end

    context "with invalid params" do
      it "does not update the task" do
        put user_task_path(user, task), params: {task: {description: ""}}

        expect(task.reload.description).to eq("Initialize cyberpunk todo item")
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE #destory" do
    let!(:task) { create(:task, user: user) }

    before do
      sign_in user
    end

    subject { delete user_task_path(user, task), as: :turbo_stream }

    it "destroy the task successfully" do
      expect { subject }.to change(Task, :count).by(-1)

      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response.body).to include("turbo-stream action=\"remove\" target=\"task_#{task.id}\"")
    end
  end
end
