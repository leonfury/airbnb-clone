# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}
user['password'] = '123'
# user['password_confirmation'] = 'asdf'

# ActiveRecord Base Transation will roll back entire database if bump into error
ActiveRecord::Base.transaction do 
  5.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.unique.email
    # user['gender'] = rand(1..2)
    # user['phone'] = Faker::PhoneNumber.phone_number
    # user['country'] = Faker::Address.country
    # user['birthdate'] = Faker::Date.between(50.years.ago, Date.today)

    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  100.times do 
    listing['title'] = Faker::App.name
    listing['description'] = Faker::Hipster.sentence
    # listing['place_type'] = rand(1..3)
    # listing['property_type'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample

    # listing['room_number'] = rand(0..5)
    # listing['bed_number'] = rand(1..6)
    # listing['guest_number'] = rand(1..10)

    listing['country'] = Faker::Address.country
    listing['state'] = Faker::Address.state
    listing['district'] = Faker::Address.city
    # listing['zipcode'] = Faker::Address.zip_code
    listing['address'] = Faker::Address.street_address

    listing['room'] = rand(1..5)
    listing['bath'] = rand(1..5)
    listing['adult'] = rand(1..15)
    listing['children'] = rand(1..15)
    listing['price'] = rand(80..1000)
   

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end