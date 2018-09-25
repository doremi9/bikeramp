require 'rails_helper'

describe Statistics::WeeklyRidesGenerator, type: :service do
  let!(:ride_today) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Plac Europejski 1, Warszawa',
      price: 123.21,
      date: Date.current,
      distance: 10
    )
  end
  let!(:ride_1_day_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: 1.day.ago,
      distance: 15
    )
  end
  let!(:ride_8_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Rosoła 45, Warszawa',
      price: 123.11,
      date: 8.days.ago,
      distance: 15
    )
  end
  let(:total_distance_current_week) do
    [ride_today, ride_1_day_ago].map(&:distance).sum
  end
  let(:total_price_current_week) do
    [ride_today, ride_1_day_ago].map(&:price).sum
  end

  subject { described_class.new }

  before { Timecop.freeze(Time.new(2018, 9, 25, 10, 30).utc) }
  after { Timecop.return }

  it 'calculates total distance made given week' do
    result = subject.call
    expect(result[:total_distance]).to eq("#{total_distance_current_week}km")
  end

  it 'calculates total price collected given week' do
    result = subject.call
    expect(result[:total_price]).to eq("#{total_price_current_week}PLN")
  end
end