class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :reservations

  validates :city, presence: true
  validates :address, presence: true
  validates :title, presence: true
  validates :user, presence: true

  SEARCH_RANGE = 0..99

  def self.search(search_params)
    city(search_params[:city])
  end

  def self.city(city)
    query_if_present(city) do |f|
      where("city ILIKE ?", "%#{f}%")
    end
  end

  def self.query_if_present(term, &block)
    if term.present?
      block.call(term)
    else
      all
    end
  end
end
