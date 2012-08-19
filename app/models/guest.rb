class Guest < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :phone_number, :gender

  # validate presence but NOT inclusion.
  # it is acceptable and expected that duplicate names will exist
  validates_presence_of :first_name, :last_name

  # gender must be present and included in @@valid_genders
  validates_presence_of :gender
  # should return genders in lexicographical order always
  @@valid_genders = ['female', 'male'].sort
  validates :gender, inclusion: { in: @@valid_genders }

  has_many :photos
  has_and_belongs_to_many :events
  has_and_belongs_to_many :guestlists
  has_one :user

  def self.genders
    @@valid_genders
  end
end
