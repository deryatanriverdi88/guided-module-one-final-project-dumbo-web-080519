class Meetup < ActiveRecord::Base
  has_many :rsvps
  has_many :users, through: :rsvps
  belongs_to :group
end
