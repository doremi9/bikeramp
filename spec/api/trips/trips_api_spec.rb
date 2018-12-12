# frozen_string_literal: true

require 'rails_helper'

describe 'TripsAPI', type: :request do
  let(:user) { create(:user) }
  describe 'POST /api/trips' do
    let(:start_address) { 'Plac Europejski 2, Warszawa' }
    let(:destination_address) { 'Aleje Jerozolimskie 10, Warszawa' }
    let(:price) { '23.21' }
    let(:date) { '20.09.2018' }
    let(:response_attributes) { response_body }
    subject { post '/api/trips', params: attributes, headers: headers }

    context 'when user is authenticated' do
      let(:headers) { auth_headers(user) }

      context 'with valid params' do
        let(:attributes) do
          {
            start_address: start_address,
            destination_address: destination_address,
            price_cents: price,
            date: date
          }
        end

        include_examples 'responds with JSON'
        include_examples '201'

        it 'creates a ride' do
          expect { subject }.to change(Ride, :count).by(1)
        end
      end

      shared_examples 'does not create a new ride' do
        it 'does not create a new ride' do
          expect { subject }.not_to change(Ride, :count)
          expect(response.status).to eq(406)
        end
      end

      context 'with invalid params' do
        context 'with empty params' do
          let(:attributes) { {} }

          it_behaves_like 'does not create a new ride'
        end
        context 'with invalid price and date' do
          let(:attributes) do
            {
              start_address: 123,
              destination_address: 123,
              price_cents: 'John Doe',
              date: 'ABCDEFGH'
            }
          end

          it_behaves_like 'does not create a new ride'
        end
      end
    end
    context 'when user is not authenticated' do
      let(:attributes) do
        {
          start_address: start_address,
          destination_address: destination_address,
          price_cents: price,
          date: date
        }
      end
      include_examples 'Unauthenticated' 
    end
  end

  describe 'GET /api/trips' do

    subject { get '/api/trips', headers: headers }
    
    context 'when user is authenticated' do
      let!(:ride1) do
        Ride.create(
          start_address: 'Plac Europejski 2, Warszawa',
          destination_address: 'Aleje Jerozolimskie 10, Warszawa',
          price_cents: 100,
          date: '2018-10-20',
          user: user
        )
      end
      let!(:ride2) do
        Ride.create(
          start_address: 'Plac Europejski 2, Warszawa',
          destination_address: 'Aleje Jerozolimskie 10, Warszawa',
          price_cents: 80,
          date: '2018-10-10',
          user: user
        )
      end
      let(:headers) { auth_headers(user) }
      
      include_examples '200'
      include_examples 'responds with JSON'
      
      it "returns user's rides ordered by date ascending" do
        subject
        expect(response_body).to be_kind_of(Array)
        expect(response_body.first['date']).to eq('2018-10-10')
        expect(response_body.second['date']).to eq('2018-10-20')
      end
    end

    context 'when user is not authenticated' do
      include_examples 'Unauthenticated'
    end
  end

  describe 'PATCH /api/trips/:id' do
    let(:ride) do
      Ride.create(
        start_address: 'Plac Europejski 2, Warszawa',
        destination_address: 'Aleje Jerozolimskie 10, Warszawa',
        price_cents: 80,
        date: '2018-10-10',
        user: user
      )
    end
  
    let(:params) do
      {
        id: id,
        start_address: 'Piękna 5, Łódź',
        destination_address: 'Brzydka 666, Łódź'
      }
    end

    subject { patch "/api/trips/#{id}", headers: headers, params: params }

    context 'when user is authenticated' do
      let(:headers) { auth_headers(user) }

      context 'when the ride exists ' do
        let(:id) { ride.id }
        
        include_examples '204'
        
        it 'updates the rides with attribtues set in params' do
          subject
          updated_ride = ride.reload
          expect(updated_ride.start_address).to eq(params[:start_address])
          expect(updated_ride.destination_address).to eq(params[:destination_address])
        end
       
        context 'when ride does not exist' do
          let(:id) { not_existing_id(Ride) }

          include_examples '404'
        end
      end
    end

    context 'when user is not authenticated' do
      let(:id) { ride.id }

      include_examples 'Unauthenticated'
    end
  end

  describe 'DELETE /api/trips/:id' do
    subject { delete "/api/trips/#{id}", headers: headers }

    context 'when user is authenticated' do
      let(:headers) { auth_headers(user) }

      context 'when ride exists' do
        let(:ride) do
          Ride.create(
            start_address: 'Plac Europejski 2, Warszawa',
            destination_address: 'Aleje Jerozolimskie 10, Warszawa',
            price_cents: 80,
            date: '2018-10-10',
            user: user
          )
        end
        let(:id) { ride.id }

        include_examples '204'
      end

      context 'when the ride does not exist' do
        let(:id) { not_existing_id(Ride) }

        include_examples '404'
      end
    end

    context 'when user is not authenticated' do
      let(:id) { ride.id }
    end
  end
end
