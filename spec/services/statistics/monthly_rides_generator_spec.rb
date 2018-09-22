require 'rails_helper'

describe Statistics::MonthlyRidesGenerator, type: :service do
  let(:date1) { 8.days.ago }
  let(:date2) { 10.days.ago }
  let(:date3) { 3.months.ago }

  let!(:ride_same_day_1) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Plac Europejski 1, Warszawa',
      price: 123.21,
      date: date1,
      distance: 10
    )
  end
  let!(:ride_same_day_2) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Plac Europejski 1, Warszawa',
      price: 123.21,
      date: date1,
      distance: 10
    )
  end
  let!(:ride_another_day_1) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: date2,
      distance: 15
    )
  end
  let!(:ride_another_day_2) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: date2,
      distance: 15
    )
  end
  let!(:ride_2_months_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Rosoła 45, Warszawa',
      price: 123.11,
      date: date3,
      distance: 15
    )
  end
  let(:avg_price_1) do
    ([ride_same_day_1, ride_same_day_2].map(&:price).sum / 2).to_f
  end
  let(:avg_price_2) do
    ([ride_another_day_1, ride_another_day_2].map(&:price).sum / 2).to_f
  end

  subject { described_class.new }

  it 'returns a list of calculated statistics with proper data' do
    result = subject.call
    expect(result.size).to eq(2)
    expect(result.first).to eq(
      {
        day: format_date(date2),
        total_distance: '30km',
        avg_ride: '15km',
        avg_price: "#{avg_price_2}PLN"
      }
    )
    expect(result.second).to eq(
      {
        day: format_date(date1),
        total_distance: '20km',
        avg_ride: '10km',
        avg_price: "#{avg_price_1}PLN"
      }
    )
  end

  def format_date(date)
    date.strftime("%B, #{date.day.ordinalize}")
  end
end