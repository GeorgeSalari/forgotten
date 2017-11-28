class ForumController < ApplicationController
  layout "layout_forum"

  def index
    @groups = check_access(Group.all).includes(:themes)
    Group.set_location
  end
end
