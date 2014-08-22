class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user

  validates :listing, presence: true
  validates :user, presence: true
  validates :date, presence: true
end
