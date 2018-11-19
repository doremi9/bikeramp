# frozen_string_literal: true

require 'rails_helper'

describe Rides::CreateRide, type: :service do
  let(:start_address) { 'Plac Europejski 2, Warszawa' }
  let(:destination_address) { 'Aleje Jerozolimskie 10, Warszawa' }
  let(:price_cents) { 12_345 }
  let(:date) { Date.current }
  let(:current_user) do
    User.create(email: 'some@email.com', password: 'secret_password')
  end
  subject { described_class.new(params, current_user) }

  describe '#call' do
    context 'valid params' do
      let(:params) do
        {
          start_address: start_address,
          destination_address: destination_address,
          price_cents: price_cents,
          date: date
        }
      end

      it 'creates a new ride' do
        ride = subject.call
        expect(ride).to be_success
      end

      it 'sets proper attributes to the Ride' do
        result = subject.call
        expect(result.data.start_address).to eq(start_address)
        expect(result.data.destination_address).to eq(destination_address)
        expect(result.data.price_cents).to eq(12_345.0)
        expect(result.data.date).to eq(date)
        expect(result.data.user_id).to eq(current_user.id)
        expect(result.data.distance).to eq(1650)
      end
    end
    context 'invalid params' do
      let(:params) { {} }

      it 'does not create a new ride' do
        result = subject.call
        expect(result).to be_failure
        expect(result.message).to eq(
          ["Start address can't be blank",
           "Destination address can't be blank",
           "Price cents can't be blank",
           'Price cents is not a number',
           "Date can't be blank",
           'Price is not a number']
        )
      end
    end
  end
end
