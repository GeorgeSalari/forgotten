class ClanMembersController < ApplicationController
  include UsersHelper
  def index
    @clan_members = ClanMember.all
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

  private
  def clan_member_params
    params.require(:clan_member).permit(:race, :nick_name, :player_link, :player_level, :player_post, :city, :name, :birthday, :department)
  end
end
