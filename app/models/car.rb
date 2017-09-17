class Car < ApplicationRecord
  has_many :bookings

  validates :model, :presence => true
  validates :manufacturer, :presence => true
  validates :number, :presence => true
  validates :rate, :presence => true
  validates :style, :presence => true
  validates :location, :presence => true
  validates :status, :presence => true, :inclusion => { :in => ['a', 'c', 'r'] }
end
