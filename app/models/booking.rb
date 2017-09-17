class Booking < ApplicationRecord
  belongs_to :user, :car
end
