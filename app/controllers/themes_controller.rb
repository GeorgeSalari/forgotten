class ThemesController < ApplicationController
  layout "layout_forum"

  def new
    @theme = Theme.new
    @group = Group.find(params[:group_id])
  end

  def create
    if current_user.superadmin? || current_user.admin?
      theme = Theme.new(theme_params)
      theme.acces_for_all = theme.group.acces_for_all
      if theme.save
        flash[:notice] = "Вы создали тему: #{theme.title}!"
        redirect_to group_path(theme.group_id)
      else
        flash[:error] = "Введите название темы!"
        render 'themes/new'
      end
    else
      flash[:error] = "Вы не можете создавать группы!"
      redirect_to forum_path
    end
  end

  def show
    if logged_in?
      theme = check_access_when_show(check_access(Theme.all), params[:id])
      unless theme.nil?
        @theme = theme
        Theme.set_location(@theme)
      else
        redirect_to no_access_path
      end
    else
      redirect_to please_log_in_path
    end
  end

  def destroy
    theme = Theme.find(params[:id])
    if current_user.superadmin?
      flash[:notice] = "Вы удалили группу: #{theme.title}!"
      theme.destroy
      redirect_to forum_path
    else
      flash[:error] = "Вы не можете удалить тему!"
      redirect_to forum_path
    end
  end

  private
  def theme_params
    params.require(:theme).permit(:title, :group_id)
  end
end
