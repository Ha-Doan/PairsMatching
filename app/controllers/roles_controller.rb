class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def index
    @role = current_user.role
  end

  def show; end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params
      .require(:role)
      .permit(:role, :user_id)
  end
end
