require 'rails_helper'

describe Statistics::WeeklyRidesGenerator, type: :service do
  let!(:ride_2_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Plac Europejski 1, Warszawa',
      price: 123.21,
      date: 2.days.ago,
      distance: 10
    )
  end
  let!(:ride_3_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: 3.days.ago,
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
    [ride_2_days_ago, ride_3_days_ago].map(&:distance).sum
  end
  let(:total_price_current_week) do
    [ride_2_days_ago, ride_3_days_ago].map(&:price).sum
  end

  subject { described_class.new }

  it 'calculates total distance made given week' do
    result = subject.call
    expect(result[:total_distance]).to eq("#{total_distance_current_week}km")
  end

  it 'calculates total price collected given week' do
    result = subject.call
    expect(result[:total_price]).to eq("#{total_price_current_week}PLN")
  end
end