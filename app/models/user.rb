class User < ApplicationRecord
  has_secure_password

  geocoded_by :address
  after_validation :geocode

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'

  has_many :personal_messages, dependent: :destroy

  mount_uploader :image, ImageUploader
end
