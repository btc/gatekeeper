class Table < ActiveRecord::Base
  attr_accessible :name, :number

  has_many :reservations

  validates_uniqueness_of :number

  validates_presence_of :name, :number

  default_scope order('number ASC')

  def to_s
    "#{self.name} (##{self.number})"
  end

  def to_label
    "#{self.number} #{self.name}"
  end

  def self.free_on(date, id = nil)
    @tables = self.scoped
    if id.present?
      @tables.delete_if { |table| !table.free_on(date) && table.id != id }
    else
      @tables.delete_if { |table| !table.free_on(date) }
    end

    @tables
  end

  def free_on(date)
    return true if date == nil || date == '' || date == []
    if self.reservations.where(date: date).empty?
      true
    else
      false
    end
  end

  def reservation_on(date)
    self.reservations.where(date: date).first
  end
end
