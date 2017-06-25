class User < ApplicationRecord
  has_secure_password

  geocoded_by :address
  after_validation :geocode
end
