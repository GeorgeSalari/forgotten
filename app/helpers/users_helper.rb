module UsersHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def check_access(gived_class)
    if current_user.user?
      gived_class.where(acces_for_all: true)
    else
      gived_class
    end
  end

  def check_access_when_show(gived_object, params)
    if gived_object.exists?(params)
      gived_object.find(params)
    else
      nil
    end
  end
end
