puts 'Seeding database...'

Rides::CreateRide.new(
  start_address: 'Aleje Jerozolimskie 10, Warszawa',
  destination_address: 'Plac Zamkowy, Warszawa',
  price: 23.99,
  date: 1.day.ago
).call

Rides::CreateRide.new(
  start_address: 'Marii Grzegorzewskiej 4, Warszawa',
  destination_address: 'Plac Europejski 2, Warszawa',
  price: 18.2,
  date: 3.days.ago
).call

Rides::CreateRide.new(
  start_address: 'Płaskowickiej 4, Warszawa',
  destination_address: 'Rondo Waszyngtona, Warszawa',
  price: 99.9,
  date: 8.days.ago
).call

Rides::CreateRide.new(
  start_address: 'Jana Rosoła 2, Warszawa',
  destination_address: 'Aleja Krakowska 10, Warszawa',
  price: 15.99,
  date: 10.days.ago
).call

Rides::CreateRide.new(
  start_address: 'Nowoursynowska 89, Warszawa',
  destination_address: 'Adama Mickiewicza 4, Warszawa',
  price: 78.29,
  date: 20.days.ago
).call

Rides::CreateRide.new(
  start_address: 'Racławicka 10, Warszawa',
  destination_address: 'Batorego 2, Warszawa',
  price: 61.11,
  date: 21.days.ago
).call

Rides::CreateRide.new(
  start_address: 'Koszykowa 7, Warszawa',
  destination_address: 'Bracka 2, Warszawa',
  price: 123.12,
  date: 21.days.ago
).call

puts 'Seeds done.'
