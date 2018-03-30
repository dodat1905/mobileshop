# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  name = Faker::LeagueOfLegends.masteries
  Brand.create(name: name, 
    created_at: Time.zone.now)
end

50.times do |n|
  name  = Faker::LeagueOfLegends.champion
  brand = Faker::Number.between(1, 10)
  description = Faker::LeagueOfLegends.quote
  price = 1000000
  product = Product.new(name: name, description: description, price: price,
    created_at: Time.zone.now, available: true, percent: brand)
  product.brand_id = brand
  product.save
end
