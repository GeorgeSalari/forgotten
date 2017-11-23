class GroupsController < ApplicationController
  layout "layout_forum"
  include UsersHelper

  def new
    @group = Group.new
  end

  def create
    if current_user.superadmin?
      @group = Group.new(group_params)
      if @group.save
        flash[:notice] = "Вы создали группу: #{@group.title}!"
        redirect_to forum_path
      else
        flash[:error] = "Введите название группы!"
        render 'groups/new'
      end
    else
      flash[:error] = "Вы не можете создавать группы!"
      redirect_to forum_path
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    group = Group.find(params[:id])
    if current_user.superadmin?
      flash[:notice] = "Вы удалили группу: #{group.title}!"
      group.destroy
      redirect_to forum_path
    else
      flash[:error] = "Вы не можете удалить группу!"
      redirect_to forum_path
    end
  end

  private
  def group_params
    params.require(:group).permit(:title)
  end
end
