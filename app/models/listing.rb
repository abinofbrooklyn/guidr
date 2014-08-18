class Listing < ActiveRecord::Base
  belongs_to :user

  validates :city, presence: true
  validates :address, presence: true
  validates :title, presence: true
  validates :user, presence: true
end
