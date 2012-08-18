class Committee < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :events
  has_and_belongs_to_many :users
end
