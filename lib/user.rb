class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :rsvps
  has_many :meetups, through: :rsvps

  def self.handle_new_user
    puts "What do you want your username to be?"
    username = STDIN.gets.chomp
    User.create(name: username)
  end

  def self.handle_returning_user
    puts "What is your username?"
    username = STDIN.gets.chomp
    if User.find_by(name: username)
      User.find_by(name: username)
    else
      puts "No user with that username exists. Try again."
      Interface.welcome
    end
  end

  def join_group(group)
    if !Membership.find_by(user_id: self.id, group_id: group.id)
      Membership.create(
        user_id: self.id,
        user_name: self.name,
        group_id: group.id,
        group_name: group.title
      )
    else
      puts "You are already a member of this group!"
    end
    Interface.main_menu(self)
  end

  def find_memberships
      Membership.select do |membership|
        membership.user_id == self.id
      end
  end

  def list_groups
    # binding.pry
    membership_array = self.find_memberships
    if membership_array != []
      membership_menu = membership_array.map do |membership|
        ["#{membership.group_name}", membership]
      end
      membership_hash = membership_menu.to_h
      membership_prompt = TTY::Prompt.new.select("Pick a group:", membership_hash)
      Interface.group_menu(self, membership_prompt)
    else
      puts "You are not in any groups!"
      Interface.main_menu(self)
    end
  end

  def leave_group(membership_object)
    membership_object.destroy
    puts "You have left the group successfully."
    Interface.main_menu(self)
  end

  def create_rsvp(meetup_object)
    Rsvp.create(user_id: self.id, meetup_id: meetup_object.id)
    puts "You have RSVP'd to this meetup!"
    Interface.main_menu(self)
  end

end
