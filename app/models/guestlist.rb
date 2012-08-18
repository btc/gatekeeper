class Guestlist < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :guests
  belongs_to :user
end
