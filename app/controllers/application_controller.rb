class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user! # user must be logged in to view any page

  # every request must go through cancan
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end
