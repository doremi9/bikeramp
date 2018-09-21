require 'rails_helper'

describe Rides::CurrentWeekRidesQuery, type: :query do
  let!(:current_week_ride_1) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Plac Europejski 1, Warszawa',
      price: 123.21,
      date: 2.days.ago,
      distance: 10
    )
  end
  let!(:current_week_ride_2) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: 3.days.ago,
      distance: 15
    )
  end
  let!(:previous_week_ride) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Rosoła 45, Warszawa',
      price: 123.11,
      date: 8.days.ago,
      distance: 15
    )
  end

  subject { described_class.new }

  describe '#call' do
    it 'returns correct statistics for the rides made in current week' do
      result = subject.call
      expect(result[:total_distance]).to eq('25km')
      expect(result[:total_price]).to eq('246.43PLN')
    end
  end
end