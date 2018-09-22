require 'rails_helper'

describe 'StatisticsAPI', type: :request do
  let!(:ride_2_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Plac Europejski 1, Warszawa',
      price: 123.1,
      date: "20.09.2018",
      distance: 18
    )
  end
  let!(:ride_3_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 42.9,
      date: '19.09.2018',
      distance: 25
    )
  end
  let!(:ride_8_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Rosoła 45, Warszawa',
      price: 83.92,
      date: '14.09.2018',
      distance: 10
    )
  end
  let!(:ride_20_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: '02.09.2018',
      distance: 15
    )
  end

  shared_examples 'responds with JSON' do
    it 'responds with JSON' do
      subject
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'GET /api/stats/weekly' do
    let(:total_week_distance) do
      [ride_3_days_ago, ride_2_days_ago].map(&:distance).sum
    end
    let(:total_week_price) do
      [ride_3_days_ago, ride_2_days_ago].map(&:price).sum
    end

    subject { get '/api/stats/weekly' }

    it_behaves_like 'responds with JSON'

    it 'returns total distance and total price made current week' do
      subject
      expect(response.parsed_body).to eq(
        {
          'total_distance' => "#{total_week_distance}km",
          'total_price' => "#{total_week_price}PLN"
        }
      )
    end
  end

  describe 'GET /api/stats/monthly' do
    subject { get '/api/stats/monthly' }

    it_behaves_like 'responds with JSON'

    it 'returns day, total distance, average ride and average price made current month' do
      subject
      expect(response.parsed_body).to eq(
        [
          {
            'day' => 'September, 2nd',
            'total_distance' => '15km',
            'avg_ride' => '15km',
            'avg_price' => '123.22PLN'
          },
          {
            'day' => 'September, 14th',
            'total_distance' => '10km',
            'avg_ride' => '10km',
            'avg_price' => '83.92PLN'
          },
          {
            'day' => 'September, 19th',
            'total_distance' => '25km',
            'avg_ride' => '25km',
            'avg_price' => '42.9PLN'
          },
          {
            'day' => 'September, 20th',
            'total_distance' => '18km',
            'avg_ride' => '18km',
            'avg_price' => '123.1PLN'
          }
        ]
      )
    end
  end
end