class ReservationsController < ApplicationController
  helper DateHelpers

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

  def show
    @reservation = find_reservation

    if current_user.id != @reservation.user_id
      flash[:alert] = "Sorry, you can only view reservations made by you."
      redirect_to @reservation.listing
    end
  end

  def index
    @reservations = current_user.reservations
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

  def find_reservation
    Reservation.find(params[:id])
  end
end
