class UsersController < ApplicationController
before_action :authenticate_user!
before_action :set_user, only: [:show, :update]

  def index
    @user = current_user
    @users = User.all
  end

  def show

  end
  def edit; end

  def update
    if @user.update(user_params)
      @user.update_attribute(:role, "admin")
      redirect_to user_path(@user.id), notice: "User updated"
    else
      render :edit
    end
  end
  private
  def user_params
    params.permit(:email, :role)
  end
  def set_user
      @user = User.find(params[:id])
  end


end
