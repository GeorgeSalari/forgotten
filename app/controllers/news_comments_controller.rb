class NewsCommentsController < ApplicationController
  def create
    @comment = NewsComment.new(comment_params)
    listing = Listing.find(@comment.listing_id)
    if @comment.save
      flash[:notice] = "Комментарий успешно добавлен!"
      redirect_to listing_path(listing)
    else
      flash[:error] = "Что то пошло не так, повторите!"
      redirect_to listing_path(listing)
    end
  end

  def destroy
    if NewsComment.exists?(params[:id])
      comment = NewsComment.find(params[:id])
      listing = Listing.find(comment.listing_id)
      if comment.user_id == current_user.id
        comment.destroy
        flash[:notice] = "Комментарий успешно удален!"
        redirect_to listing_path(listing)
      else
        flash[:error] = "Это не ваш комментарий! Вы не можете его удалить!"
        redirect_to listing_path(listing)
      end
    else
      flash[:error] = "Нет такого комментария!"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if NewsComment.exists?(params[:id])
      @comment = NewsComment.find(params[:id])
      listing = Listing.find(@comment.listing_id)
      if @comment.user_id == params[:news_comment][:user_id].to_i
        @comment.update(comment_params.reject{|_, v| v.blank?})
        flash[:notice] = "Комментарий был изменен успешно!"
        redirect_to listing_path(listing)
      else
        flash[:error] = "Это не ваш комментарий! Вы не можете его изменить!"
        redirect_to listing_path(listing)
      end
    else
      flash[:error] = "Нет такого комментария!"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:news_comment).permit(:quote_head, :quote_content, :user_id, :listing_id, :content)
  end
end
