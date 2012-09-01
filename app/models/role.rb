class Role < ActiveRecord::Base
  # OPTIMIZE use a HABTM relationship between users and roles
  # in order to conserver database space
  # it's preetty wasteful to use an individual
  # role object for each entry in the database

  @valid_roles = %w[door_attendant committee_member manager admin]

  attr_accessible :name, :user_id

  # a role isn't valid without a user associated with it
  validates_presence_of :user_id
  # one role per user
  validates_uniqueness_of :name, :scope => :user_id

  # ensure that only valid roles get committed to the database
  validates(:name,
            inclusion: { in: @valid_roles,
                         message: '%{value} is not a valid role'
                         }
            )

  belongs_to :user, inverse_of: :roles

  def self.roles
    @valid_roles
  end
end
