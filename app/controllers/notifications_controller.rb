class NotificationsController < ApplicationController
  skip_authorization_check

  def post_full_name
    @user = current_user
    @user.full_name = params[:full_name]
    if @user.save
      flash[:notice] = 'thanks!'
      redirect_to root_path
    end
  end
end
