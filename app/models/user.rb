class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  class Guest
    def name
      "Guest"
    end
  end
end
