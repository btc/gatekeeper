require 'chronic' # NL date parsing

class Reservation < ActiveRecord::Base
  attr_accessible :date, :table_id, :guest_list_id, :guest_id, :description

  belongs_to :table
  belongs_to :guest_list
  belongs_to :guest
  validates_uniqueness_of :table_id, scope: :date, allow_nil: true
  validates_presence_of :date

  # NOT before_save (since date is a required field and validation occurs first)
  before_validation :parse_date

  scope :dateless, where(date: nil)
  scope :dated, where('date IS NOT NULL')

  default_scope order('date DESC')

  def parse_date
    if self.date_before_type_cast
      self.date = Chronic.parse(self.date_before_type_cast, context: :future)
    end
  end

  def to_s
    guest = case self.guest.present?
            when true
              "#{self.guest}'s reservation"
            else
              'nameless reservation'
            end
    table = case self.table.present?
            when true
              "at #{self.table}"
            else
             ''
            end
    date = case self.date.present?
           when true
             "(#{self.date.strftime('%A %e %B')})"
           else
            '(no date associated)'
           end
    [guest, table, date].join(' ')
  end
end
