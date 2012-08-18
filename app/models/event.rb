class Event < ActiveRecord::Base
  attr_accessible :title
  has_and_belongs_to_many :committees
  has_and_belongs_to_many :guests

  validates_presence_of :title
end
