class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :roles
  has_and_belongs_to_many :committees
  belongs_to :guest

  def is_admin?
    Role.is_admin? self
  end

  def admin=(bool)
    if bool == true
      Role.add_admin(self)
    end
  end

end
