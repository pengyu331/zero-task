# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User Oauth (GitHub)", type: :request do
  describe "GET /users/auth/github/callback" do
    context "when github returns the valid credentials" do
      before do
        OmniAuth.config.mock_auth[:github] =
          OmniAuth::AuthHash.new(
            {
              provider: "github",
              uid: "123456",
              info: {email: "messi@github.com", name: "Lionel Messi"},
              credentials: {token: "mock_token", secret: "mock_secret"}
            }
          )
      end

      it "creates a new user and redirects to home page" do
        expect do
          get user_github_omniauth_callback_path
        end.to change(User, :count).by(1)

        expect(response).to redirect_to(root_path)

        follow_redirect!
        expect(response.body).to include("Successfully authenticated from GitHub account")
      end

      it "redirects to home page without creating new user when user exists" do
        create(:user, email: "messi@github.com", password: "password123", provider: "github", uid: "123456")

        expect do
          get user_github_omniauth_callback_path
        end.not_to change(User, :count)

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Sign Out")
      end
    end

    context "when github returns the invalid credentials" do
      before do
        OmniAuth.config.mock_auth[:github] = :invalid_credentials
      end

      it "redirects to the sign in page" do
        get user_github_omniauth_callback_path

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
