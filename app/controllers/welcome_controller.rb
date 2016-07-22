class WelcomeController < ApplicationController
  def index
  	# @listings = Listing.all.paginate(:page => params[:page], :per_page => 30)
  	# @listings = @listings.where(bedrooms: params["bedrooms"]) if params["bedrooms"].present?
  	# @listings = @listings.where(state: params["state"]) if params["state"].present?
  	# @listings = @listings.where(price: params["price"]) if params["price"].present?
  	
  end

  def listing_params
  	# params.require(:listing).permit(:date, :address, :listing_title, :price, :bedrooms, :square_ft, :city)
  end
end
