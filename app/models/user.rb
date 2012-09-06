class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :full_name

  has_many :roles, inverse_of: :user
  has_and_belongs_to_many :committees
  belongs_to :guest

  def is_god?
    true if self.email == 'brian.holderchow@gmail.com'
  end

  def has_role?(role_name)
    Role.find_by_user_id_and_name(self.id, role_name.to_s) ? true : false
  end

  def add_role!(role_name)
    r = self.roles.build
    r.name = role_name.to_s
    r.save!
    r # return
  end

  def remove_role!(role_name)
    r = Role.find_by_user_id_and_name(self.id, role_name.to_s)
    r.destroy
  end

  def to_s
    name = self.full_name
    if name.nil? || name.blank?
      name = self.email
    end
    return name
  end

  def <=>(another_user)
    self.to_s.downcase <=> another_user.to_s.downcase
  end
end
