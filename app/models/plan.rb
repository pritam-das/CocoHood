class Plan < ApplicationRecord
  # Associating event with user so that only users may create events.
  belongs_to :user
end
