class Photo < ActiveRecord::Base
  # attr_accessible :title, :body
  has_attached_file :image, styles: {
    medium: '300x300>',
    thumb: '100x100>'
  }

  belongs_to :guest
end