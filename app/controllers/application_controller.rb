class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user! # user must be logged in to view any page
end
