class ListingsController < ApplicationController
  def index
  	@listings = Listing.all
    @jsonListings = []
    @listings.each do |t|
      if t.state != "" && t.city != ""
        @jsonListings.push(t)
      end
    end
    @json = @jsonListings.to_json
  end
  
  def new
  	@listing = Listing.new
  	render :new
  end

  def create
  	@listing = Listing.create(listing_params)
  	redirect_to listing_path(@listing.id)
  end

  def edit
  end

  def show
  	@listing = Listing.find(params[:id])
    render :show
  end

  def listing_params
  	params.require(:listing).permit(:date, :address, :listing_title, :price, :bedrooms, :square_ft, :city)
  end
end
