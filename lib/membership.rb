class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def find_group_object
    Group.find(self.group_id)
  end

  def find_user_object
    User.find(self.user_id)
  end

  def check_upcoming_events(user_object)
    meetup_array = self.find_group_object.upcoming_events
    if meetup_array != []
      meetup_menu = meetup_array.map do |meetup|
        ["#{meetup.location}; #{meetup.date}", meetup]
      end
      meetup_hash = meetup_menu.to_h
      meetup_prompt = TTY::Prompt.new.select("Select an upcoming event", meetup_hash)
      Interface.meetup_menu(user_object, meetup_prompt)
    else
      puts "This group does not have any upcoming meetups!"
      Interface.main_menu(self)
    end
  end

  def show_description(user_object)
    this_group = self.find_group_object
    puts this_group.description
    return_prompt = TTY::Prompt.new.keypress("Press enter or space to go back", keys: [:space, :return])
    Interface.group_menu(user_object, self)
  end

  # membership_array = self.find_memberships
  # if membership_array != []
  #   membership_menu = membership_array.map do |membership|
  #     ["#{membership.group_name}", membership]
  #   end
  #   membership_hash = membership_menu.to_h

end
