class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Привет #{@user.nick_name}!"
      redirect_to "/"
    else
      flash[:error] = @user.check_errors(@user.errors)
      render 'users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :nick_name, :player_link, :email, :password)
  end
end

