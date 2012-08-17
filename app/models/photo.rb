class Photo < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :guest
end
