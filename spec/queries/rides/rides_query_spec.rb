require 'rails_helper'

describe RidesQuery, type: :query do
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

  before { Timecop.freeze(Time.new(2018, 9, 25, 10, 30).utc) }
  after { Timecop.return }

  describe '#rides_weekly' do
    it 'returns rides made in current week' do
      result = subject.rides_weekly
      expect(result).to include(ride_today, ride_1_day_ago)
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
    it 'returns rides made in current month' do
      result = subject.rides_monthly
      expect(result).to include(
        ride_today, ride_1_day_ago, ride_8_days_ago, ride_20_days_ago,
        ride_20_days_ago_2
      )
    end

    it 'does not return rides made prior current month' do
      result = subject.rides_monthly
      expect(result).not_to include(ride_25_days_ago, ride_3_months_ago)
    end
  end
end
