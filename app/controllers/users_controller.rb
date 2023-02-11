class UsersController < ApplicationController
  before_action :set_user, only: [:update]

  def new
    @user = User.new
  end

  def update
  end

  def settings
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
