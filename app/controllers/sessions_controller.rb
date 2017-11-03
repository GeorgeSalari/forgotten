class SessionsController < ApplicationController
  def create
    @user = User.find_by(nick_name: params[:session][:nick_name])
    if @user
      if @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        flash[:notice] = "Привет #{@user.nick_name}!"
        redirect_to '/'
      else
        flash[:error] = "Не верный пароль!"
        redirect_to '/'
      end
    else
      flash[:error] = "Такой логин не зарегестрирован на сайте!"
      redirect_to '/'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "До скорых встреч!"
    redirect_to '/'
  end
end
