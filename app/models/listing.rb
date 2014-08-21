class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :available_dates

  validates :city, presence: true
  validates :address, presence: true
  validates :title, presence: true
  validates :user, presence: true

  def self.search(search_params)
    if search_params[:city].present?
      city(search_params[:city])
    else
      all
    end
  end

  def self.city(city)
    where("city ILIKE ?", "%#{city}%")
  end

  def reserve(user, date_range)
    if available_during?(date_range)
      book(user, date_range)
    else
      NullReservation.new
    end
  end

  private

  def available_during?(date_range)
    count_dates_between(date_range) == count_available_dates_between(date_range)
  end

  def count_dates_between(date_range)
    date_range.days_in_range
  end

  def count_available_dates_between(date_range)
    available_date_range(date_range).count
  end

  def available_date_range(date_range)
    the_range = date_range.start_date..date_range.end_date
    available_dates.where(start_date: the_range, end_date: the_range)
  end
end
