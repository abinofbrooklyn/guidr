class Listing < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode
  belongs_to :user
  has_many :reservations
  has_many :available_dates
  has_many :reviews, through: :reservations

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

  def make_available_on(date)
    available_dates.new(date).save
  end

  def reserve(user, request_date)
    if available_on?(request_date)
      book(user, request_date)
    else
      NullReservation.new
    end
  end

  private

  def available_on?(request_date)
    available_dates.where(date: request_date).exists?
  end

  def book(user, request_date)
    transaction do
      book_on(request_date)
      create_reservation(user, request_date)
    end
  end

  def book_on(request_date)
    available_dates.where(date: request_date).destroy_all
  end

  def create_reservation(user, request_date)
    Reservation.create(
      user: user,
      date: request_date,
      listing: self
    )
  end
end
