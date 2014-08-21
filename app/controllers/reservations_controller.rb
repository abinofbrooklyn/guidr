class ReservationsController < ApplicationController

  def new
    @listing = find_listing
    @reservation = Reservation.new
  end

  def create
    @listing = find_listing

    if valid_dates?
      @reservation = @listing.reserve(
        current_user, date)
    end

    if @reservation && @reservation.valid?
      redirect_to @reservation
    else
      flash.now[:alert] = "Reservation date is invalid"
      @reservation = Reservation.new
      render :new
    end
  end

  private

  def find_listing
    Listing.find(params[:listing_id])
  end

  def valid_dates?
    date.present? 
  end

  def date
    reservation_params[:date]
  end

  def reservation_params
    params.require(:reservation).permit(:date)
  end
end
