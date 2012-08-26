class Invitation < ActiveRecord::Base
  attr_accessible :event_id, :guest_id, :guest_list_id, :plus, :redeemed, :date

  belongs_to :guest
  belongs_to :event
  belongs_to :guest_list

  validates_presence_of :date, :guest_list, :guest, :redeemed
end
