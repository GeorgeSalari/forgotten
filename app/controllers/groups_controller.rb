class GroupsController < ApplicationController
  layout "layout_forum"

  def new
    @group = Group.new
  end

  def create
    if current_user.superadmin?
      @group = Group.new(group_params)
      @group.acces_for_all = false if params[:group][:acces_for_all].to_i == 0
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
    if logged_in?
      group  = check_access_when_show(check_access(Group.all), params[:id])
      unless group.nil?
        @group = group
        Group.set_location_show(@group)
      else
        redirect_to no_access_path
      end
    else
      redirect_to please_log_in_path
    end
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
