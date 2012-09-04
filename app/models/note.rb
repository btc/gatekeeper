class Note < ActiveRecord::Base
  attr_accessible :body

  validates_presence_of :body
  validates_length_of :body, in: (1..140)

  before_validation :strip_body

  belongs_to :guest
  belongs_to :user

  default_scope order('updated_at DESC')

  private
  def strip_body
    self.body.strip! if self.body.present?
  end
end
