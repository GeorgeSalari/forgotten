class PostsController < ApplicationController
  layout "layout_forum"

  def create
    post = Post.new(post_params)
    if post.save
      flash[:notice] = "Вы написали ответ на топик: #{post.topic.title}"
      redirect_to topic_path(post.topic)
    else
      flash[:error] = "Что то пошло не так! Попробуйте снова!"
      render "topics/#{post.topic.id}"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if current_user.id == post.user_id || current_user.admin? || current_user.superadmin?
      if post.update(post_params.reject{|_, v| v.blank?})
        flash[:notice] = "Вы отредактировали ответ"
        redirect_to topic_path(post.topic_id)
      else
        flash[:error] = "Что-то пошло не так! Попробуйте еще раз!"
        render "topics/#{post.topic_id}"
      end
    else
      flash[:error] = "Вы не можете редактировать ответы!"
      redirect_to topic_path(post.topic_id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user.id == post.user_id || current_user.admin? || current_user.superadmin?
      post.destroy
      flash[:notice] = "Вы удалили ответ!"
      redirect_to topic_path(post.topic_id)
    else
      flash[:error] = "Вы не можете удалять ответы!"
      redirect_to topic_path(post.topic_id)
    end
  end

  private
  def post_params
    params.require(:post).permit(:content, :user_id, :topic_id, :theme_id)
  end
end
