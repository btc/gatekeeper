class Table < ActiveRecord::Base
  attr_accessible :name, :number

  has_many :reservations
end
