class Interface
  attr_accessor :prompt
  @@prompt = TTY::Prompt.new

  # def initialize
  #   @@prompt = TTY::Prompt.new
  # end

  def self.welcome
    system "clear"
    @@prompt.say("Welcome to Random Meetup Finder!", color: :red)
    user_object = @@prompt.select("Are you a new or returning user?") do |menu|
      menu.choice "New User", -> {User.handle_new_user}
      menu.choice "Returning User", -> {User.handle_returning_user}
    end
    if user_object
      self.main_menu(user_object)
    else
      Interface.welcome
    end
  end

  def self.main_menu(user_object)
    system "clear"
    @@prompt.say("Welcome #{user_object.name}!", color: :red)
    puts "Age: #{user_object.age}, Location: #{user_object.location}"
    @@prompt.select("Main menu :") do |menu|
      menu.choice "Find a random group.", -> {Group.find_random_group(user_object)}
      menu.choice "See what groups you are a member of.", -> {user_object.list_groups}
      menu.choice "See which events you have RSVP'd to.", -> {user_object.show_rsvp}
      menu.choice "Update your account information.", -> {user_object.update_account_info}
      menu.choice "Exit.", -> {exit!}
    end
  end

  def self.group_menu(user_object, membership_object)
      puts "#{membership_object.group_name}:"
      @@prompt.select("What would you like to do?") do |menu|
        menu.choice "See upcoming events.", -> {membership_object.check_upcoming_events(user_object)}
        menu.choice "See group description.", -> {membership_object.show_description(user_object)}
        menu.choice "Leave this group.", -> {user_object.leave_group(membership_object)}
        menu.choice "Go back to main menu.", -> {Interface.main_menu(user_object)}
      end
  end

  def self.meetup_menu(user_object, meetup_object)
    @@prompt.select("What would you like to do?") do |menu|
      menu.choice "RSVP to this event.", -> {user_object.create_rsvp(meetup_object)}
      menu.choice "Go back to main menu.", -> {Interface.main_menu(user_object)}
    end
  end

  def self.rsvp_menu(user_object, rsvp_object)
    @@prompt.select("What would you like to do?") do |menu|
      menu.choice "Delete RSVP.", -> {user_object.destroy_rsvp(rsvp_object)}
      menu.choice "Go back to main menu.", -> {Interface.main_menu(user_object)}
    end
  end

end
