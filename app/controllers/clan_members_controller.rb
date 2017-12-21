class ClanMembersController < ApplicationController

  def index
    @clan_members = ClanMember.show_members(params[:department], params[:order_members])
  end

  def new
    @clan_member = ClanMember.new
  end

  def create
    if current_user.admin? || current_user.superadmin?
      @clan_member = ClanMember.new(clan_member_params)
      if @clan_member.save
        flash[:notice] = "Игрок #{@clan_member.nick_name} добавлен в состав"
        redirect_to clan_members_path
      else
        flash[:notice] = @clan_member.check_error
        render "clan_members/new"
      end
    else
      flash[:notice] = "У вас нет прав редактировать состав!"
      redirect_to "/"
    end
  end

  def admining_members
    @clan_members = ClanMember.all
  end

  def edit
    @clan_member = ClanMember.find(params[:id])
  end

  def update
    if current_user.admin? || current_user.superadmin?
      clan_member = ClanMember.find(params[:id])
      if clan_member.update(clan_member_params)
        flash[:notice] = "Параментры игрока #{clan_member.nick_name} были успешно изменены!"
        redirect_to admining_members_path
      else
        flash[:error] = "Что то пошло не так! Попробуйте снова!"
        render 'clan_members/edit'
      end
    else
      flash[:error] = "У вас нет прав удалять игроков из состава!"
      redirect_to clan_members_path
    end
  end

  def destroy
    if current_user.admin? || current_user.superadmin?
      if ClanMember.exists?(params[:id])
        clan_member = ClanMember.find(params[:id])
        clan_member.destroy
        flash[:notice] = "Вы удалили игрока из состава!"
        redirect_to admining_members_path
      else
        flash[:notice] = "Такого пользователя нет в составе!"
        redirect_to admining_members_path
      end
    else
      flash[:notice] = "У вас нет прав удалять игроков из состава!"
      redirect_to clan_members_path
    end
  end

  private
  def clan_member_params
    params.require(:clan_member).permit(:race, :nick_name, :player_link, :player_level, :player_post, :city, :name, :birthday, :department)
  end
end
