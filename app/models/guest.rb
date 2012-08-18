class Guest < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :phone_number

  # validate presence but NOT inclusion.
  # it is acceptable and expected that duplicate names will exist
  validates_presence_of :first_name, :last_name

  has_many :photos
  has_and_belongs_to_many :events
  has_and_belongs_to_many :guestlists
  has_one :user
end
