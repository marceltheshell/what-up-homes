class ListingsController < ApplicationController
  def index
  	@listings = Listing.all
  end
  
  def new
  	@listing = Listing.new
  	render :new
  end

  def create
  	@listing = Listing.new
  	listing.save
  end

  def edit
  end

  def show
  	@listing = Listing.find(params[:id])
    render :show
  end
end
