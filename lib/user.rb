class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :rsvps
  has_many :meetups, through: :rsvps

  def self.find_by_id(user_id)
    self.all.find do |user|
      user.id == user_id
    end
  end

  def self.find_name_by_id(user_id)
    self.find_by_id(user_id).name
  end

  def join_group(group)
    Membership.create(
      user_id: self.id,
      user_name: self.name,
      group_id: group.id,
      group_name: group.title
    )
  end

  def list_groups
    Membership.select do |membership|
      membership.user_id == self.id
    end
  end

  def leave_group(selected_group_id)
    group_to_destroy = self.list_groups.find do |memberships|
      memberships.group_id == selected_group_id
    end
    group_to_destroy.destroy
  end

end
