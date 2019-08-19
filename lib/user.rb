class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :rsvps
  has_many :meetups, through: :rsvps

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
