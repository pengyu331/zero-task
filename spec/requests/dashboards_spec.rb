# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Dashboards", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: "xavi@github.com") }

  describe "GET /index" do
    context "when user is not authenticated" do
      it "redirects to the signin page" do
        get user_dashboard_path(user)

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticted" do
      before do
        sign_in user
      end

      it "renders the dashboard successfully" do
        get user_dashboard_path(user)

        expect(response).to have_http_status(:success)
        expect(response.body).to include("Dashboard")
      end

      it "try to access another user's dashboard" do
        get user_dashboard_path(other_user)

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to match(/Access Denied/)
      end
    end
  end
end
