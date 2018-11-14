# frozen_string_literal: true

require 'rails_helper'

describe 'StatisticsAPI', type: :request do
  before { Timecop.freeze(Time.new(2018, 9, 25, 10, 30).utc) }

  let!(:user) do
    User.create(
      email: 'email@mail.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end
  let!(:ride_today) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Plac Europejski 1, Warszawa',
      price: 123.1,
      date: '25.09.2018',
      distance: 18,
      user: user
    )
  end
  let!(:ride_1_day_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 42.9,
      date: '24.09.2018',
      distance: 25,
      user: user
    )
  end
  let!(:ride_8_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Rosoła 45, Warszawa',
      price: 83.92,
      date: '14.09.2018',
      distance: 10,
      user: user
    )
  end
  let!(:ride_20_days_ago) do
    Ride.create!(
      start_address: 'Aleje Jerozolimskie 10, Warszawa',
      destination_address: 'Marii Grzegorzewskiej 4, Warszawa',
      price: 123.22,
      date: '02.09.2018',
      distance: 15,
      user: user
    )
  end

  after { Timecop.return }

  describe 'GET /api/stats/current_week' do
    subject { get '/api/stats/current_week', headers: headers }

    context 'authenticated user' do
      let(:headers) { auth_headers(user) }
      let(:total_week_distance) do
        [ride_1_day_ago, ride_today].map(&:distance).sum
      end
      let(:total_week_price) do
        [ride_1_day_ago, ride_today].map(&:price).sum
      end

      include_examples 'responds with JSON'
      include_examples '200'

      it 'returns total distance and total price made current week' do
        subject
        expect(response_body).to eq(
          [{
            'id' => ride_1_day_ago.id,
            'start_address' => ride_1_day_ago.start_address,
            'destination_address' => ride_1_day_ago.destination_address,
            'distance' => ride_1_day_ago.distance,
            'price' => ride_1_day_ago.price.to_f,
            'date' => ride_1_day_ago.date.strftime('%Y-%m-%d'),
            'user_id' => user.id
          },
          {
            'id' => ride_today.id,
            'start_address' => ride_today.start_address,
            'destination_address' => ride_today.destination_address,
            'distance' => ride_today.distance,
            'price' => ride_today.price.to_f,
            'date' => ride_today.date.strftime('%Y-%m-%d'),
            'user_id' => user.id
          }]
        )
      end
    end

    context 'unauthenticated user' do
      include_examples 'Unauthenticated'
    end
  end

  describe 'GET /api/stats/current_month' do
    subject { get '/api/stats/current_month', headers: headers }

    include_examples 'responds with JSON'

    context 'authenticated user' do
      let(:headers) { auth_headers(user) }

      include_examples '200'

      it 'returns proper response' do
        subject
        expect(response_body).to eq(
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
              'day' => 'September, 24th',
              'total_distance' => '25km',
              'avg_ride' => '25km',
              'avg_price' => '42.9PLN'
            },
            {
              'day' => 'September, 25th',
              'total_distance' => '18km',
              'avg_ride' => '18km',
              'avg_price' => '123.1PLN'
            }
          ]
        )
      end
    end

    context 'unauthenticated user' do
      include_examples 'Unauthenticated'
    end
  end
end
