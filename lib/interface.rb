class Interface
  attr_accessor :prompt
  @@prompt = TTY::Prompt.new

  # def initialize
  #   @@prompt = TTY::Prompt.new
  # end

  def self.welcome
    puts "Welcome to Random Meetup Finder!"
    user_object = @@prompt.select("Are you a new or returning user?") do |menu|
      menu.choice "New User", -> {User.handle_new_user}
      menu.choice "Returning User", -> {User.handle_returning_user}
    end
    self.main_menu(user_object)
  end

  def self.main_menu(user_object)
    puts "Welcome #{user_object.name}!"
    @@prompt.select("Main menu :") do |menu|
      menu.choice "Find a random group.", -> {Group.find_random_group(user_object)}
      menu.choice "See what groups you are a member of.", -> {user_object.list_groups}
      menu.choice "See which events you have RSVP'd to.", -> {user_object.show_rsvp}
      menu.choice "Exit.", -> {exit!}
    end
  end

  def self.group_menu(user_object, membership_object)
      puts "#{membership_object.group_name}:"
      group_menu_prompt = TTY::Prompt.new.select("What would you like to do?") do |menu|
        menu.choice "See upcoming events.", -> {membership_object.check_upcoming_events(user_object)}
        menu.choice "See group description.", -> {membership_object.show_description(user_object)}
        menu.choice "Leave this group.", -> {user_object.leave_group(membership_object)}
        menu.choice "Go back to main menu.", -> {Interface.main_menu(user_object)}
      end
  end

  def self.meetup_menu(user_object, meetup_object)
    event_menu = TTY::Prompt.new.select("What would you like to do?") do |menu|
      menu.choice "RSVP to this event.", -> {user_object.create_rsvp(meetup_object)}
      menu.choice "Go back to main menu.", -> {Interface.main_menu(user_object)}
    end
  end

end
