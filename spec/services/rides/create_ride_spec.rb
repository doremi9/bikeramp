require 'rails_helper'

describe Rides::CreateRide, type: :service do

  let(:start_address) { 'Marii Grzegorzewskiej 4, Warszawa, Polska' }
  let(:destination_address) { 'Zakopane, Polska' }
  let(:price) { 1234 }
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
          price: price,
          date: date
        }
      end
      let(:start_address_coords) { [25.372, -23.218] }
      let(:destination_coords) { [145.964, 89.263] }
      let(:distance) { 327.45673 }

      before do
        allow(Geocoder).to receive(:coordinates)
          .with(params[:start_address])
          .and_return(start_address_coords)
        allow(Geocoder).to receive(:coordinates)
          .with(params[:destination_address])
          .and_return(destination_coords)
        allow(Geocoder::Calculations).to receive(:distance_between)
          .with(start_address_coords, destination_coords)
          .and_return(distance)
      end

      it 'creates a new ride' do
        ride = subject.call
        expect(ride).to be_success
      end

      it 'sets proper attributes to the Ride' do
        result = subject.call
        expect(result.data.start_address).to eq(start_address)
        expect(result.data.destination_address).to eq(destination_address)
        expect(result.data.price).to eq(price)
        expect(result.data.date).to eq(date)
        expect(result.data.user_id).to eq(current_user.id)
        expect(result.data.distance).to eq(distance.round(0))
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
           "Price can't be blank",
           "Date can't be blank"]
        )
      end
    end
  end
end
