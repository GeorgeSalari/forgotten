class PostsController < ApplicationController
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

  private
  def post_params
    params.require(:post).permit(:content, :user_id, :topic_id, :theme_id)
  end
end
