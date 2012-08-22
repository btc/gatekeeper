class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user! # user must be logged in to view any page
  check_authorization unless: :devise_controller?               # every request must go through cancan

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end
