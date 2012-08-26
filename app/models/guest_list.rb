class GuestList < ActiveRecord::Base
  attr_accessible :date, :owner_id, :creator_id, :event_id

  belongs_to :creator, class_name: 'User'
  belongs_to :owner, class_name: 'Guest'
  belongs_to :event
  has_many :invitations
  has_many :guests, through: :invitations

  validates_presence_of :date, :owner, :creator

  has_paper_trail
end
