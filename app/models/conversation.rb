class Conversation < ApplicationRecord

  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :author, uniqueness: {scope: :receiver}

end
