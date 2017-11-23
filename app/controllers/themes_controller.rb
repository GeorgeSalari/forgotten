class ThemesController < ApplicationController
  layout "layout_forum"
  include UsersHelper

  def new
    @theme = Theme.new
    @group = Group.find(params[:group_id])
  end

  def create
    if current_user.superadmin? || current_user.admin?
      theme = Theme.new(theme_params)
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

  private
  def theme_params
    params.require(:theme).permit(:title, :group_id)
  end
end
