class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user! # user must be logged in to view any page
  before_filter :check_user_full_name

  # every request must go through cancan
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def check_user_full_name
    if current_user && current_user.full_name.blank?
      link = "<i class='icon-warning-sign'></i> "
      link << ActionController::Base.helpers.link_to('please add your name',
        users_name_path)
      flash[:warning] = link.html_safe
    end
  end
end
