require 'chronic'

class Event < ActiveRecord::Base
  attr_accessible :title, :date
  has_and_belongs_to_many :committees
  has_and_belongs_to_many :guests

  before_save :parse_date

  validates_presence_of :title

  def parse_date
    if self.date_before_type_cast
      self.date = Chronic.parse(self.date_before_type_cast, context: :future)
    end
  end

end
