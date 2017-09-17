class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings
  validates :name, :presence => true

=begin
  validates :name, :presence => true
  validates :email, :presence => true, :format => {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, :presence => true, :confirmation => true, :length => {:within => 4..20}
  validates :level, :inclusion => { :in => ['c', 'a', 's'] }
=end
end
