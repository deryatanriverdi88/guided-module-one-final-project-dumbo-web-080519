class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  def upcoming_events
    Meetup.all.select do |meetup|
      meetup.group_id == self.id
    end    
  end

end
