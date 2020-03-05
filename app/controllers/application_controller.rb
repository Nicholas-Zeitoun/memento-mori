class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def configure_permitted_parameters
    # To ask and allow user to add a username when signing up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :location, :avatar])
    # To allow user to add an avatar when updating profile
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end
end
