class Photo < ActiveRecord::Base
  # attr_accessible :title, :body
  has_attached_file :image, styles: {
    medium: '300x300>',
    thumb: '100x100>'
  }

  belongs_to :guest

  def self.generate_file_name(options = {})
    n = 10000000000000000000000000000000000000000000000000000000000000
    return SecureRandom.random_number(n).to_s(36) + options[:extension]
  end
end
