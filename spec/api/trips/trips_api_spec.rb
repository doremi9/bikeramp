require 'rails_helper'

describe 'TripsAPI', type: :request do
  describe 'POST /api/trips' do
    let(:start_address) { 'Plac Europejski 2, Warszawa' }
    let(:destination_address) { 'Aleje Jerozolimskie 10, Warszawa' }
    let(:price) { '23.21' }
    let(:date) { '20.09.2018' }
    let(:response_attributes) { response_body }
    let(:user) { User.create(email: 'email@mail.com', password: 'password', password_confirmation: 'password') }
    subject { post '/api/trips', params: attributes, headers: auth_headers(user) }

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
        expect(response.status).to eq(200)
      end
    end

    shared_examples 'does not create a new ride' do
      it 'does not create a new ride' do
        expect { subject }.not_to change { Ride.count }
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
            price: 'John Doe',
            date: 'ABCDEFGH'
          }
        end

        it_behaves_like 'does not create a new ride'
      end
    end
  end
end
