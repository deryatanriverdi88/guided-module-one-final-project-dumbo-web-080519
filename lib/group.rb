class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships


  def self.find_random_group(user_object)
    random_group = Group.all.sample
    puts random_group.title
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

end
