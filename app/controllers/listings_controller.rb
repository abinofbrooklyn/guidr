class ListingsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)

    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @location = Gmaps4rails.build_markers(@listing) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
    end
    @user = User.find(params[:id])
  end

  def destroy
    listing = Listing.find(params[:id])
    listing.destroy
    redirect_to listing
  end

  private
  
  def listing_params
    params.
      require(:listing).
      permit(
        :city,
        :address,
        :title,
        :description,
        :longitude,
        :latitude
      )
  end
end
