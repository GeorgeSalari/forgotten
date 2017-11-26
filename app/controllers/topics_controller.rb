class TopicsController < ApplicationController
  layout "layout_forum"
  include UsersHelper

  def new
    @topic = Topic.new
    @theme = Theme.find(params[:theme_id])
  end

  def create
    topic = Topic.new(topic_params)
    if topic.save
      flash[:notice] = "Вы создали топик: #{topic.title}"
      redirect_to topic_path(topic)
    else
      flash[:error] = "Заполните все поля!"
      render "topics/new"
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic.increase_view_count
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :content, :group_id, :theme_id, :user_id)
  end
end
