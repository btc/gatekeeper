class Guest < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name,
    :phone_number, :gender, :rating

  # validate presence but NOT inclusion.
  # it is acceptable and expected that duplicate names will exist
  validates_presence_of :first_name, :last_name

  # gender must be present and included in @@valid_genders
  validates_presence_of :gender
  # should return genders in lexicographical order always
  @@valid_genders = ['female', 'male'].sort
  validates :gender, inclusion: { in: @@valid_genders }

  # rating must be in range, but is not required
  @@valid_ratings = (1..5)
  validates :rating, inclusion: { in: @@valid_ratings }, allow_nil: true

  has_many :photos
  has_and_belongs_to_many :events
  has_and_belongs_to_many :guestlists
  has_one :user

  def self.genders
    @@valid_genders
  end

  def self.ratings
    @@valid_ratings
  end

  def is_five_star?
    self.rating == 5
  end
end
