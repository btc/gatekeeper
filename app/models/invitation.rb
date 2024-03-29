class Invitation < ActiveRecord::Base
  attr_accessible :event_id, :guest_id, :guest_list_id, :plus, :redeemed, :tag_list

  belongs_to :guest
  belongs_to :event
  belongs_to :guest_list, inverse_of: :invitations

  # never validate presence of redeemed
  validates_presence_of :guest_list, :guest

  has_paper_trail

  acts_as_taggable_on :tags

  def date
    self.guest_list.date
  end

  def to_s
    self.guest.try(:full_name)
  end
end
