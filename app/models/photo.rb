class Photo < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :guest

  def self.generate_file_name(options = {})
    n = 10000000000000000000000000000000000000000000000000000000000000
    return SecureRandom.random_number(n).to_s(36) + options[:extension]
  end
end
