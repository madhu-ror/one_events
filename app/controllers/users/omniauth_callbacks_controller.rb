# frozen_string_literal: true
#
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.where(email: request.env["omniauth.auth"].info.email).first
    if @user.present? && @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      @user = User.new
      @user.first_name = request.env["omniauth.auth"].info.first_name
      @user.middle_name = request.env["omniauth.auth"].info.middle_name
      @user.last_name = request.env["omniauth.auth"].info.last_name
      @user.email = request.env["omniauth.auth"].info.email
      @user.provider = request.env["omniauth.auth"].provider
      @user.uid = request.env["omniauth.auth"].uid
      render 'users/registrations/new'
    end
  end

  def failure
    redirect_to root_path
  end
end

#class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
#end
