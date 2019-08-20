require_relative '../config/environment'

cli = Interface.new
user_object = cli.welcome

while !user_object
  user_object = cli.welcome
end

cli.user = user_object
binding.pry
