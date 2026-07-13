# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Access Control", type: :request do
  describe "GET /" do
    context "when user is not signed in" do
      it "redirects to the sign in page" do
        get root_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is signed in" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "returns a successful response" do
        get root_path
        expect(response).to be_successful
      end
    end
  end
end
