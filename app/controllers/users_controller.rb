class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = "Привет #{@user.nick_name}! Подтверди свою почту!"
      redirect_to "/"
    else
      flash[:error] = @user.check_errors(@user.errors)
      render 'users/new'
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:notice] = "Добро пожаловать! Вы успешно активировали свой аккаунт!"
      redirect_to '/'
    else
      flash[:error] = "Такого пользователя нет!"
      redirect_to '/'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user.nil? || @user.id == current_user.id || current_user.superadmin?
      if @user.update(user_params.reject{|_, v| v.blank?})
        @user.set_passwroed_token_empty
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

  def reset_password

  end

  def resend_email_confirmation

  end

  def repeat_email_confirmation
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      if user.email_confirmation
        flash[:notice] = "Привет #{user.nick_name}! Ваша почта уже активирована!"
        redirect_to "/"
      else
        UserMailer.registration_confirmation(user).deliver
        flash[:notice] = "Привет #{user.nick_name}! На вашу почту было отправленно повторное письмо!"
        redirect_to "/"
      end
    else
      flash[:error] = "Нет такой почты в базе данных!"
      render 'users/resend_email_confirmation'
    end
  end

  def email_for_new_password
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      user.set_password_token
      UserMailer.reset_user_password(user).deliver_now
    else
      flash[:error] = "Нет такой почты в базе данных!"
      render 'users/reset_password'
    end
  end

  def new_password
    user = User.find_by_reset_password_token(params[:id])
    if user
      @user = user
    else
      flash[:error] = "Такого пользователя нет!"
      redirect_to '/'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :birthday, :nick_name, :player_link, :email, :password, :profile_photo)
  end
end

