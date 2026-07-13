# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    handle_auth "GitHub"
  end

  def failure
    error = request.env["omniauth.error"]
    error_type = request.env["omniauth.error.type"]
    Rails.logger.error(
      "[OmniAuth] failure type=#{error_type.inspect} " \
      "error=#{error.class}: #{error&.message}"
    )

    redirect_to new_user_session_url, alert: "登录失败：#{error_type || "unknown"}"
  end

  private

  def handle_auth(kind)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      session["devise.#{kind.downcase}_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url, alert: " 登录失败，请注册或绑定邮箱"
    end
  end
end
