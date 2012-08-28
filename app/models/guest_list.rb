require 'chronic'

class GuestList < ActiveRecord::Base
  attr_accessible :date, :owner_id, :creator_id, :event_id

  belongs_to :creator, class_name: 'User'
  belongs_to :owner, class_name: 'Guest'
  belongs_to :event
  has_many :invitations
  has_many :guests, through: :invitations

  validates_presence_of :date, :owner, :creator
  before_save :parse_date

  has_paper_trail

  def parse_date
    if self.date_before_type_cast
      self.date = Chronic.parse(self.date_before_type_cast, context: :future)
    end
  end

end
