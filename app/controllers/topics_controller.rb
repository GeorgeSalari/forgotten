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
    @topic = Topic.where(id: params[:id]).includes(:user).first
    @topic.increase_view_count
    @posts = Post.where(topic_id: @topic.id).includes(:user)
    @post = Post.new
  end

  def edit
    @topic = Topic.find(params[:id])
    @theme = Theme.find(params[:theme_id])
  end

  def update
    topic = Topic.find(params[:id])
    if current_user.id == topic.user_id || current_user.admin? || current_user.superadmin?
      if topic.update(topic_params)
        flash[:notice] = "Вы отредактировали топик: #{topic.title}"
        redirect_to topic_path(topic)
      else
        flash[:error] = "Заполните все поля!"
        render "topics/edit"
      end
    else
      flash[:error] = "Вы не можете редактировать топики!"
      redirect_to forum_path
    end
  end

  def destroy
    topic = Topic.find(params[:id])
    if current_user.id == topic.user_id || current_user.admin? || current_user.superadmin?
      flash[:notice] = "Вы удалили топик: #{topic.title}"
      topic.destroy
      redirect_to forum_path
    else
      flash[:error] = "Вы не можете удалять топики!"
      redirect_to forum_path
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :content, :group_id, :theme_id, :user_id)
  end
end
