require 'chronic'

class GuestList < ActiveRecord::Base
  attr_accessible :date, :owner_id, :creator_id, :event_id

  belongs_to :creator, class_name: 'User'
  belongs_to :owner, class_name: 'Guest'
  belongs_to :event
  has_many :invitations, dependent: :destroy, inverse_of: :guest_list
  has_many :guests, through: :invitations

  validates_presence_of :date, :owner, :creator
  # NOT before_save (since date is a required field and validation occurs first)
  before_validation :parse_date

  has_paper_trail

  def parse_date
    if self.date_before_type_cast
      self.date = Chronic.parse(self.date_before_type_cast, context: :future)
    end
  end

end
