class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, presence: true 
  validates :password, presence: true, on: :create
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  before_save :email_lowercase
  has_many :events, dependent: :destroy 
  has_many :comments, dependent: :destroy 
  has_many :attendee, through: :events 
  has_many :events_attending, through: :attendee, source: :events 
  def email_lowercase
      email.downcase!
  end 
end
