class ListingsController < ApplicationController
  def index
    @listings = Listing.order(created_at: :desc)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      flash[:notice] = "Новость создана!"
      redirect_to "/"
    else
      flash[:error] = "Все поля должны быть заполнены!"
    end
  end

  def show
    @comment = NewsComment.new
    @listing = Listing.find(params[:id])
    @listing.increase_view_count
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      flash[:notice] = "Новость отредактирована!"
      redirect_to listing_path(@listing)
    else
      flash[:error] = "Все поля должны быть заполнены!"
      render 'listings/edit'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    if @listing
      @listing.destroy
      flash[:notice] = "Новость удалена!"
      redirect_to '/'
    else
      flash[:notice] = "Нет такой новости!"
      redirect_to '/'
    end
  end

  private
  def listing_params
    params.require(:listing).permit(:user_id, :title, :short_content, :full_content)
  end
end
