class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    byebug
    @user = User.new(user_params)
    if @user.save
    else
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :nick_name, :player_link, :email, :password)
  end
end

