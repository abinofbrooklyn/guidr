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
    @geojson = []

     @geojson << {
        type: "Feature",
        geometry: {
          type: "Point",
          coordinates: [@listing.longitude, @listing.latitude]
        },
        properties: {
          name: @listing.title,
          address: @listing.address,
            :"maker-color" => "#00607d",
            :"marker-symbol" => "circle",
            :"marker-size" => "medium"
        }
      }

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
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
