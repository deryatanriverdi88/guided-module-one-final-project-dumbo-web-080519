class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships


  def self.find_random_group(user_object)
    system "clear"
    random_group = Group.all.sample
    puts Pastel.new.red(random_group.title)
    random_group_prompt = TTY::Prompt.new.select("What would you like to do?") do |menu|
      menu.choice "See the description.", -> {random_group.show_description(user_object)}
      menu.choice "Join this group.", -> {user_object.join_group(random_group)}
      menu.choice "Find a new suggestion.", -> {Group.find_random_group(user_object)}
      menu.choice "Go back to main menu.", -> {Interface.main_menu(user_object)}
    end
  end

  def show_description(user_object)
    puts self.description
    description_prompt = TTY::Prompt.new.select("What would you like to do?") do |menu|
      menu.choice "Join this group.", -> {user_object.join_group(self)}
      menu.choice "Find me another suggestion.", -> {Group.find_random_group(user_object)}
      menu.choice "Go back to main menu.", -> {Interface.main_menu(user_object)}
    end
  end

  def upcoming_events
    Meetup.all.select do |meetup|
      meetup.group_id == self.id
    end
  end

  def find_memberships
    Membership.all.select do |membership|
      membership.group_id == self.id
    end
  end

  def find_user_list(user_object)
    memberships = self.find_memberships
    user_list = memberships.map do |membership|
      membership.user_name
    end
    user_list.uniq!
    puts Pastel.new.green("This group has #{user_list.size} members: ")
    puts user_list
    TTY::Prompt.new.keypress(Pastel.new.red("Press any key to return to menu."))
    Interface.main_menu(user_object)
  end

end
