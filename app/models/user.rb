class User < ApplicationRecord
  has_many :bookings

  validates :name, :presence => true
  validates :email, :presence => true, :format => {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, :presence => true, :confirmation => true, :length => {:within => 4..20}
  validates :level, :inclusion => { :in => ['c', 'a', 's'] }
end
