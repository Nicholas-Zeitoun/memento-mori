class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # To ask and allow user to add a username when signing up
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :location ])
    # To allow user to add an avatar when updating profile
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar_url, :avatar, :username])
  end

  def default_url_options
    { host: ENV["www.meme-forrest.fun"] || "localhost:3000" }
  end
end
