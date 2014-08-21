class ReservationsController < ApplicationController

  def new
    @listing = find_listing
    @reservation = Reservation.new
  end

  def create
    @listing = find_listing

    if valid_dates?
      @reservation = @listing.reserve(
        current_user,
        DateRange.new(start_date: start_date, end_date: end_date)
      )
    end

    if @reservation && @reservation.valid?
      redirect_to @reservation
    else
      flash.now[:alret] = "Reservation date is invalid"
      @reservation = Reservation.new
      render :new
    end
  end

  private

  def find_listing
    Listing.find(params[:listing_id])
  end

  def valid_dates?
    start_date.present? && end_date.present?
  end

  def start_date
    reservation_params[:start_date].to_date
  end

  def end_date
    reservation_params[:end_date].to_date
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
