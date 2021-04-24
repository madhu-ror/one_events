class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name,:middle_name,:mobile_number,:country_code, :email, :password, :password_confirmation,:provider,:uid])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || home_page_root_path
  end
end
