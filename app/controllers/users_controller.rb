class UsersController < ApplicationController
  def settings
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    if @user.save
      redirect_to bookmarks_path
    else
      render :settings, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:frequency, :distance)
  end
end
