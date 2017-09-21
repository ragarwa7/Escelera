class User < ApplicationRecord

  enum role: [:user, :admin, :superadmin]
  after_initialize :set_default_role, :if => :new_record?


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings
  validates :name, :presence => true

  def set_default_role
    self.role ||= :user
  end

end
