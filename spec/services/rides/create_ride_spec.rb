require 'rails_helper'

describe Rides::CreateRide, type: :service do
  let(:start_address) { 'Marii Grzegorzewskiej 4, Warszawa, Polska' }
  let(:destination_address) { 'Zakopane, Polska' }
  let(:price) { 1234 }
  let(:date) { Date.current }

  subject { described_class.new(params) }

  describe '#call' do
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
      expect(ride).to be_persisted
    end

    it 'calculates the distance and rounds it to an integer' do
      ride = subject.call
      expect(ride.distance).to eq(327)
    end

    it 'sets proper attributes to the Ride' do
      ride = subject.call
      expect(ride.start_address).to eq(start_address)
      expect(ride.destination_address).to eq(destination_address)
      expect(ride.price).to eq(price)
      expect(ride.date).to eq(date)
    end
  end
end
