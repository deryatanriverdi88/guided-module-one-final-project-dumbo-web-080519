class Interface
  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end

  def welcome
    puts "Welcome to Random Meetup Finder!"
    answer = prompt.select("Are you a new or returning user?") do |menu|
      menu.choice "New User", -> {User.handle_new_user}
      menu.choice "Returning User", -> {User.handle_returning_user}
    end
    self.main_menu(answer)
  end

  def main_menu(user)
    puts "Welcome #{user.name}!"
    prompt.select("Main menu :") do |menu|
      menu.choice "Find a random group.", -> {Group.find_random_group}
      menu.choice "See what groups you are a member of.", -> {user.list_groups}
      menu.choice "Exit.", -> {}
    end
  end



end
