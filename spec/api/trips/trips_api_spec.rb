require 'rails_helper'

describe 'TripsAPI', type: :request do
  describe 'POST /api/trips' do
    let(:start_address) { 'Plac Europejski 2, Warszawa' }
    let(:destination_address) { 'Aleje Jerozolimskie 10, Warszawa' }
    let(:price) { '23.21' }
    let(:date) { '20.09.2018' }
    let(:response_attributes) { response.parsed_body }
    subject { post '/api/trips', params: attributes }

    context 'with valid params' do
      let(:attributes) do
        {
          start_address: start_address,
          destination_address: destination_address,
          price: price,
          date: date
        }
      end

      it 'responds with JSON' do
        subject
        expect(response.content_type).to eq('application/json')
      end

      it 'creates a ride' do
        expect { subject }.to change { Ride.count }.from(0).to(1)
        expect(response).to be_successful
        expect(response_attributes['start_address']).to eq(start_address)
        expect(response_attributes['destination_address']).to eq(destination_address)
        expect(response_attributes['distance']).to eq(1)
        expect(response_attributes['price']).to eq(price)
        expect(response_attributes['date']).to eq('2018-09-20')
      end
    end

    shared_examples 'does not create a new ride' do
      it 'does not create a new ride' do
        expect { subject }.not_to change { Ride.count }
        expect(response.status).to eq(400)
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
            price: 'John Doe',
            date: 1.23123
          }
        end

        it_behaves_like 'does not create a new ride'
      end
    end
  end
end
