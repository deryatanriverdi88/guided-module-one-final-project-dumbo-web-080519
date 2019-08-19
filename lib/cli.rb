def welcome
  puts "Welcome to Random Meetup Finder!"
  puts "Have you used this app before? (Y/N)"
  user_input = STDIN.gets.chomp.downcase

  if user_input == "n"
    puts "Let's make an account"
    puts "What is your name ?"
    new_username = STDIN.gets.chomp
    user_id= User.create(name: new_username).id
    main_menu(user_id)
  elsif user_input == "y"
    puts "What is your user id?"
    returning_user_id = STDIN.gets.chomp.to_i
    user_id = returning_user_id
    main_menu(user_id)
  end

end

def main_menu(user_id)
  puts "Welcome #{User.find_name_by_id(user_id)}!"
  puts "Main Menu :"
  puts "1 - Find a random group."
  puts "2 - See what groups you are in."
  puts "3 - See a group's upcoming meetings."
  puts "4 - Leave a group."
  puts "Enter the number of the menu item that you would like to access :"
  user_input  = STDIN.gets.chomp.to_i
end
