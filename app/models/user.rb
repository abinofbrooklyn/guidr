class User < ActiveRecord::Base
  acts_as_messageable
  has_many :listings
  has_many :reservations
  has_many :reserved_listings, through: :reservations, source: :listing
  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :biography, presence: true
  validates :avatar, presence: true

  def reservations_for(listing)
    reservations.where(listing: listing).includes(:listing)
  end

  def reserved?(listing)
    reserved_listing_ids.include?(listing.id)
  end

  def owns?(listing)
    listing.user_id == id
  end

  def can_change?(user)
    admin? || user == self
  end

  def name
    email
  end

  def mailboxer_email(object)
    email
  end
end
