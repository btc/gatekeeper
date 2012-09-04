class Reservation < ActiveRecord::Base
  attr_accessible :date, :table_id, :guest_list_id, :guest_id

  belongs_to :table
  belongs_to :guest_list
  belongs_to :guest
  validates_uniqueness_of :table_id, scope: :date, allow_nil: true

  scope :dateless, where(date: nil)
  scope :dated, where('date IS NOT NULL')

  default_scope order('date DESC')
end
