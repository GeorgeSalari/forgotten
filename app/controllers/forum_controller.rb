class ForumController < ApplicationController
  layout "layout_forum"

  def index
    if logged_in?
      @groups = check_access(Group.all).includes(:themes)
      Group.set_location
    else
      redirect_to please_log_in_path
    end
  end

  def please_log_in
  end

  def no_access
  end
end
