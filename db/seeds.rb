restaurants = [["Monteverde", "Chicago", "1020 W. Madison Chicago, IL 60607", "Italian", "Casual Dining",
                "$30 and under", "(312) 888-3041", "http://monteverdechicago.com/", "Located in Chicago\’s West Loop neighborhood, Monteverde is an Italian restaurant that blends the traditions of Italian culture and cooking with influences from Chef Sarah Grueneberg’s trips around the world, as well as her family heritage. Cooking with a traditional heart and a modern hand, Monteverde offers food that is soulful, surprising and filled with storytelling.",
                "https://resizer.otstatic.com/v2/photos/large/24386856.jpg", 10],
               ["Riccardo Trattoria", "Chicago", "2119 N. Clark Street Chicago, IL 60614", "Italian", "Casual Dining",
                 "$30 and under", "(773) 549-0038", "http://www.riccardotrattoria.com/index.htm", "Riccardo started his career at a very young age in Milan\'s prestigious \"GIRARROSTO\" family owned. Then, in 1982 he moved to the United States and he opened the famous Sonny Bono\'s in Los Angeles. In 1987 he started to work with his cousin Roberto Ruggeri (owner of Bice\'s Venture), with him he opened Bice New York, Los Angeles and many others around the world.",
                 "https://ot-foodspotting-production.s3.amazonaws.com/reviews/91289/thumb_600.jpg", 8]]

Restaurant.delete_all
restaurants.each do |entry|
  restaurant = Restaurant.new
  restaurant.name = entry[0]
  restaurant.city = entry[1]
  restaurant.address = entry[2]
  restaurant.cuisines = entry[3]
  restaurant.dining_style = entry[4]
  restaurant.price_range = entry[5]
  restaurant.phone_number = entry[6]
  restaurant.website = entry[7]
  restaurant.description = entry[8]
  restaurant.photo_url = entry[9]
  restaurant.number_of_tables = entry[10]
  restaurant.save
end

puts "There are now #{Restaurant.count} restaurants"



users = [["mengwang", "mengwang", "Meng", "Wang", "mengwanguc@gmail.com", 100, true],
         ["userX", "userX", "Jack", "Chen", "guest@gmail.com", 50, false]]

User.delete_all
users.each do |entry|
  user = User.new
  user.username = entry[0]
  user.password = entry[1]
  user.first_name = entry[2]
  user.last_name = entry[3]
  user.email = entry[4]
  user.points = entry[5]
  user.is_admin = entry[6]
  user.save
end

puts "There are now #{User.count} users"



reservations_data = [["2017-5-10", "11:00", "The food is great!", 5, false],
                     ["2017-5-12", "16:00", "Awesome!", 10, false]]
Reservation.delete_all
reservations_data.each do |entry|
  reservation = Reservation.new
  reservation.user_id = User.sample.id
  reservation.restaurant_id = Restaurant.sample.id
  reservation.date = entry[0]
  reservation.time = entry[1]
  reservation.review = entry[2]
  reservation.points = entry[3]
  reservation.canceled = entry[4]
  reservation.save
end

puts "There are now #{Reservation.count} reservations"









# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
