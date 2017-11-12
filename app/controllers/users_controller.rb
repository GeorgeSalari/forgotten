class UsersController < ApplicationController
  include UsersHelper
  def show
    @user = User.find(params[:id])
  end

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

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id || current_user.superadmin?
      if @user.update(user_params.reject{|_, v| v.blank?})
        flash[:notice] = "Вы отредактировали свой профиль!"
        redirect_to user_path(@user)
      else
        flash[:error] = @user.check_errors(@user.errors)
        render 'users/edit'
      end
    else
      flash[:notice] = "У вас нет прав редактировать пользователей!"
      redirect_to "/"
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :birthday, :nick_name, :player_link, :email, :password, :profile_photo)
  end
end

