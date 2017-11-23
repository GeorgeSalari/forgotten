class ForumController < ApplicationController
  layout "layout_forum"

  def index
    @groups = Group.all
    @themes = Theme.all
  end
end
