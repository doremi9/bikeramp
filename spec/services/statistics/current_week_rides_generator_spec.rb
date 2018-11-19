require 'rails_helper'

describe Statistics::CurrentWeekRidesGenerator, type: :service do
  before { Timecop.freeze(Date.new(2018, 10, 24)) }
  after { Timecop.return }

  let!(:user) do
    User.create(email: 'email@mail.com', password: 'password', password_confirmation: 'password')
  end
  let!(:ride_today) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Plac Europejski 1, Warszawa',
      price: 123.21,
      date: Date.current,
      distance: 10,
      user: user
    )
  end
  let!(:ride_1_day_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: 1.day.ago,
      distance: 15,
      user: user
    )
  end
  let!(:ride_8_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Rosoła 45, Warszawa',
      price: 123.11,
      date: 8.days.ago,
      distance: 15,
      user: user
    )
  end
  let(:total_distance_current_week) do
    [ride_today, ride_1_day_ago].map(&:distance).sum
  end
  let(:total_price_current_week) do
    [ride_today, ride_1_day_ago].map(&:price).sum.to_f
  end

  subject { described_class.new(user) }

  it 'calculates total distance made given week' do
    result = subject.call
    expect(result[:total_distance]).to eq("#{total_distance_current_week}km")
  end

  it 'calculates total price collected given week' do
    result = subject.call
    expect(result[:total_price]).to eq("#{total_price_current_week}PLN")
  end
end
