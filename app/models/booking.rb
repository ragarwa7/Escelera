class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :pickup_time, :presence => true
  validates :return_time, :presence => true
end
