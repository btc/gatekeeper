class Role < ActiveRecord::Base

  @@types = ["admin", "root", "community_leader"]

  attr_accessible :name, :user_id

  validates_presence_of :user_id
  validates_uniqueness_of :name,:scope => :user_id
  validates(:name, :inclusion => {:in => @@types,
    :message => "%{value} is not a valid role"})

  belongs_to :user

  def self.is_admin? user
    find_by_user_id_and_name(user.id, 'admin')
  end

  def self.add_admin user
    find_or_create_by_user_id_and_name user.id, 'admin'
  end

  def self.get_types
    @@types
  end

end
