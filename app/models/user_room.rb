class UserRoom < ApplicationRecord
  belongs_to :User
   belongs_to :room
end
