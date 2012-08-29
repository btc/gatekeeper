class Invitation < ActiveRecord::Base
  attr_accessible :event_id, :guest_id, :guest_list_id, :plus, :redeemed

  belongs_to :guest
  belongs_to :event
  belongs_to :guest_list, inverse_of: :invitations

  # never validate presence of redeemed
  validates_presence_of :guest_list, :guest

  has_paper_trail

  def date
    self.guest_list.date
  end
end
