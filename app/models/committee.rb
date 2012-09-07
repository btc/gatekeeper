class Committee < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title, :user_ids
  has_and_belongs_to_many :events
  has_and_belongs_to_many :users

  def to_s
    self.title
  end
end
