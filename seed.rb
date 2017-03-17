require 'pry'
require_relative 'database_config'

Dir["models/*.rb"].each {|m| require_relative m }
user = User.new(email: "test2@account.com")
user.password = "test"
user.save

ambition = Goal.create(ambition: "I want to become a programmer as well", image_url: "http://www.searchquest.co.uk/wp-content/uploads/2015/10/Programmer.jpg", user_id: user.id)


# binding.pry
