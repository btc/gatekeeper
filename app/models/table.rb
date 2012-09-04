class Table < ActiveRecord::Base
  attr_accessible :name, :number

  has_many :reservations

  validates_uniqueness_of :number

  validates_presence_of :name, :number

  default_scope order('number ASC')

end
