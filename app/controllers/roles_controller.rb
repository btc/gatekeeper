class RolesController < ApplicationController
  def update
    authorize! :manage, Role

    # given params user_id, action, role
    user_id = params[:user_id]
    role = params[:role]
    instruction = params[:instruction]

    # validate user
    @user = User.find_by_id(user_id)
    if @user.nil?
      flash[:alert] = 'please select a user'
      redirect_to action: :manage and return
    end

    # validate role
    unless Role.roles.include?(role)
      flash[:alert] = 'please select a role'
      redirect_to action: :manage and return
    end

    # validate instruction/process valid request
    case instruction
    when 'add'
      @user.add_role! role
    when 'remove'
      @user.remove_role! role
    else
      flash[:alert] = 'please select an action'
      redirect_to action: :manage and return
    end

    flash[:notice] = 'success!'
    redirect_to action: :manage and return
  end

  def manage
    authorize! :manage, Role
    @users = User.all
    @role = Role.new
  end
end
