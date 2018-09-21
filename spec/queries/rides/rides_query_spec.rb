require 'rails_helper'

describe RidesQuery, type: :query do
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
  let!(:ride_20_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: 20.days.ago,
      distance: 15
    )
  end
  let!(:ride_20_days_ago_2) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: 20.days.ago,
      distance: 15
    )
  end
  let!(:ride_25_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: 25.days.ago,
      distance: 15
    )
  end
  let!(:ride_3_months_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: 3.months.ago,
      distance: 15
    )
  end

  subject { described_class.new }

  describe '#rides_weekly' do
    it 'returns rides made in current week' do
      result = subject.rides_weekly
      expect(result).to include(ride_2_days_ago, ride_3_days_ago)
    end

    it 'does not return rides made prior current week' do
      result = subject.rides_weekly
      expect(result).not_to include(
        ride_8_days_ago,
        ride_20_days_ago,
        ride_25_days_ago,
        ride_3_months_ago
      )
    end
  end

  describe '#rides_monthly' do
    it 'returns rides only made in current month grouped and ordered by date' do
      result = subject.rides_monthly
      expect(result.keys).to eq([ride_20_days_ago.date, ride_8_days_ago.date,
                                 ride_3_days_ago.date, ride_2_days_ago.date])
      expect(result.values).to eq([
                                    [ride_20_days_ago, ride_20_days_ago_2],
                                    [ride_8_days_ago],
                                    [ride_3_days_ago],
                                    [ride_2_days_ago]
                                  ])
    end

    it 'does not return rides made prior current month' do
      result = subject.rides_monthly
      expect(result.keys).not_to include(
        ride_25_days_ago.date, ride_3_months_ago.date
      )
      expect(result.values).not_to include(
        ride_25_days_ago.date, ride_3_months_ago.date
      )
    end
  end
end
