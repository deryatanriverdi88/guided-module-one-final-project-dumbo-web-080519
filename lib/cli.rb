def welcome
  puts "Welcome to Random Meetup Finder!"
  puts "Have you used this app before? (Y/N)"
  user_input = STDIN.gets.chomp.downcase

  if user_input == "n"
    puts "Let's make an account"
    puts "What is your name ?"
    new_username = STDIN.gets.chomp
    user= User.create(name: new_username)
    main_menu(user)
  elsif user_input == "y"
    puts "What is your user id?"
    returning_user_id = STDIN.gets.chomp.to_i
    user = User.find(returning_user_id)
    main_menu(user)
  end

end

def main_menu(user)
  puts "Welcome #{user.name}!"
  puts "Main Menu :"
  puts "1 - Find a random group."
  puts "2 - See what groups you are in."
  puts "3 - See a group's upcoming meetings."
  puts "4 - Leave a group."
  puts "Enter the number of the menu item that you would like to access :"
  user_input  = STDIN.gets.chomp.to_i
end

def find_random_group(user)
  Group.all.shuffle[0]
end

def show_groups(user)
  user.list_groups
end

def show_upcoming_meetups(user, group)

end
