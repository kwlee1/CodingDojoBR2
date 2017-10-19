class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy 
  has_many :attendee, dependent: :destroy 
  has_many :attendees_user, through: :attendee, source: :user
  validates :name, :city, :state, presence: true, length: { minimum: 2 }
  validates :date, :user, presence: true

  validate :date_future
  def date_future
      if date < Date.today
          errors.add(:date, "Date must be in the future")
      end
  end
end
