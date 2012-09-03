class UsersController < ApplicationController
  skip_authorization_check
  def name
    @user = current_user
  end
end
