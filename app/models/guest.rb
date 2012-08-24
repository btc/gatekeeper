require 'chronic' # NL date parsing

class Guest < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name,
    :phone_number, :gender, :rating, :birthday,
    :photos_attributes, :notes_attributes,
    :webcam_photo_id # webcam_photo_id needed to update webcam photo in form

  acts_as_birthday :birthday

  before_save :parse_birthday

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
  has_many :notes
  has_and_belongs_to_many :events
  has_and_belongs_to_many :guestlists
  has_one :user
  has_one :creator, class_name: 'User'

  accepts_nested_attributes_for :notes,
    reject_if: proc { |attributes| attributes['body'].strip.empty? }
  accepts_nested_attributes_for :photos,
    reject_if: proc { |attributes| attributes['image'].nil? }

  # dummy method used to capture webcam photo id from guest form
  attr_accessor :webcam_photo_id

  scope :by_first_last_gender, order("LOWER(first_name) ASC, LOWER(last_name) ASC, gender ASC")

  def self.genders
    @@valid_genders
  end

  def self.ratings
    @@valid_ratings
  end

  def self.full_name_search(string)
    guests = self.all
    tokens = string.downcase.split
    guests.select! do |guest|
      keep = true
      tokens.each do |token|
        unless guest.first_name.downcase.include?(token) || guest.last_name.downcase.include?(token)
          keep = false
        end
      end
      keep
    end
    guests
  end

  def self.find_ordered_birthdays_for_the_next_month
    # fetch guests whose birthdays fall within the period
    within_range = Guest.find_birthdays_for Date.today, Date.today.next_month

    # sort them first by splitting the months apart
    separated_by_month = within_range.partition do |g|
      g.birthday.month == Date.today.month
    end

    # sort by day within each month
    separated_by_month.each do |arr|
      arr.sort_by! { |g| g.birthday.day }
    end

    # merge the two arrays to return
    separated_by_month.flatten!
  end

  def parse_birthday
    if self.birthday_before_type_cast
      self.birthday = Chronic.parse(self.birthday_before_type_cast, context: :past)
    end
  end

  def is_five_star?
    self.rating == 5
  end

  # returns most recently associated photo
  def last_photo
    self.photos.last
  end

  def full_name
    "#{self.first_name} #{self.last_name}".titlecase
  end


end
