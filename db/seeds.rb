puts 'Seeding database...'
user1 = User.create(email: 'qwe@qwe.qwe', password: 'password', password_confirmation: 'password')
user2 = User.create(email: 'some@email.com', password: 'password', password_confirmation: 'password')
user3 = User.create(email: 'another_email@sample.com', password: 'password', password_confirmation: 'password')
users = [user1, user2, user3]
dates = [1.day.ago, 2.days.ago, 3.days.ago, 1.month.ago, 2.months.ago]
start_addresses = [
  'Aleje Jerozolimskie 10, Warszawa',
  'Marii Grzegorzewskiej 4, Warszawa',
  'Płaskowickiej 4, Warszawa',
  'Jana Rosoła 2, Warszawa'
]
destination_addresses = [
  'Plac Zamkowy, Warszawa',
  'Plac Europejski 2, Warszawa',
  'Rondo Waszyngtona, Warszawa',
  'Aleja Krakowska 10, Warszawa'
]
prices = [23.99, 18.2, 99.9]
params = {
  start_address: start_addresses.sample,
  destination_address: destination_addresses.sample,
  price_cents: prices.sample,
  date: dates.sample
}
20.times do
  Rides::CreateRide.new(params, users.sample).call
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
puts 'Seeds done.'
