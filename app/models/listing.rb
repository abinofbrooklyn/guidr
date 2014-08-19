class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :reservations

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
end
