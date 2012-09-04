require 'chronic' # NL date parsing

class Guest < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name,
    :phone_number, :gender, :rating, :birthday,
    :photos_attributes, :notes_attributes,
    :webcam_photo_id # webcam_photo_id needed to update webcam photo in form

  acts_as_birthday :birthday

  before_save :parse_birthday
  after_save  :clear_cached_full_name_search_results

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
  has_many :guest_lists, through: :invitations
  has_many :invitations
  has_many :reservations
  has_and_belongs_to_many :events
  has_one :user
  belongs_to :creator, class_name: 'User'

  has_paper_trail

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

  def self.full_name_search(str)
    @@cached_full_name_search_results ||= {}
    @@cached_full_name_search_results[str] ||= self.compute_full_name_search(str)
  end

  def self.compute_full_name_search(str)
    guests = self.all
    return guests if str.nil? || str.empty?
    tokens = str.downcase.split
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

  def self.clear_cached_full_name_search_results
    @@cached_full_name_search_results = nil
  end

  def clear_cached_full_name_search_results
    Guest.clear_cached_full_name_search_results
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

  def id_name_tuple
    [{ id: self.id, name: self.full_name }]
  end

  def self.id_name_tuples(guests)
    return Array.new if guests.nil?
    tuples = guests.map { |g| { id: g.id, name: g.full_name } }
  end

  def self.duplicates(n = 0)
    if n.nil?
      ceiling = 0
    else
      ceiling = n.to_i
    end
    @@duplicates ||= {}
    @@duplicates[ceiling] ||= self.compute_duplicates(ceiling)
  end

  def self.compute_duplicates(n)
    tuples = []
    guests = self.scoped
    guests.each do |guest_a|
      guests.each do |guest_b|
        if guest_a.id != guest_b.id
          h = {}
          h[:distance] = Text::Levenshtein.distance(guest_a.full_name, guest_b.full_name)
          if h[:distance] <= n
            h[:a] = guest_a
            h[:b] = guest_b
            tuples << h
          end
        end
      end
    end
    tuples.sort_by! { |tuple| tuple[:distance] }
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

  def is_female?
    self.gender == 'female'
  end

  def is_male?
    !self.is_female?
  end

  def to_s
    self.full_name
  end
end
