class ForumController < ApplicationController
  layout "layout_forum"

  def index
    @groups = Group.all.includes(:themes)
    Group.set_location
  end
end
