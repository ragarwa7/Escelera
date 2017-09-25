class Car < ApplicationRecord
  has_many :bookings

  validates :model, :presence => true
  validates :manufacturer, :presence => true
  validates :number, :presence => true
  validates :rate, :presence => true
  validates :style, :presence => true, :inclusion => { :in => ["Hatchback", "Sedan", "SUV"] }
  validates :location, :presence => true
  validates :status, :presence => true, :inclusion => { :in => ['Available', 'Checked Out', 'Reserved'] }
end
