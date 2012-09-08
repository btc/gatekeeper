require 'chronic'

class GuestList < ActiveRecord::Base
  attr_accessible :date, :owner_id, :creator_id, :event_id, :approved, :published

  belongs_to :creator, class_name: 'User'
  belongs_to :owner, class_name: 'Guest'
  belongs_to :event
  has_one :reservation
  has_many :invitations, dependent: :destroy, inverse_of: :guest_list
  has_many :guests, through: :invitations

  validates_presence_of :date, :owner, :creator

  # NOT before_save (since date is a required field and validation occurs first)
  before_validation :parse_date

  has_paper_trail

  default_scope order('date ASC')

  # temporary solution to loading lists for friday when it is 2 am saturday
  scope :active, where("date >= ?", Date.yesterday)

  scope :pending, where("approved = ? AND published = ?", false, true)
  scope :approved, where("approved = ?", true)
  scope :tonight, lambda { where('date = ?', Nightclub.today) }

  def self.alphabetic_by_date
    self.scoped.sort_by { |list| [list.date, list.owner.try(:first_name)] }
  end

  def parse_date
    if self.date_before_type_cast
      self.date = Chronic.parse(self.date_before_type_cast, context: :future)
    end
  end

  def pct_female
    n_men = n_women = 0

    self.guests.each do |guest|
      if guest.is_female?
        n_women += 1
      else
        n_men += 1
      end
    end

    n_women.to_f / (n_men + n_women).to_f * 100
  end

  def friendly_date
    self.date.try(:strftime, '%A %e %B')
  end

  def total
    n = 0
    self.invitations.each do |i|
      n += 1 + i.plus
    end
    n
  end

  def revoke!
    self.approved = false
  end

  def approve!
    self.published = true
    self.approved = true
  end

  def draft?
    !(self.published || self.approved)
  end

  def invalid?
    !self.published && self.approved
  end

  def pending?
    self.published && !self.approved
  end

  def approved?
    self.published && self.approved
  end

  def build_invi_from_guest guest
    return nil if guest == nil
    self.invitations.each do |i|
      if i.guest.try(:id) == guest.id
        return false
      end
    end
    invitation = self.invitations.build
    invitation.guest = guest
  end
end
