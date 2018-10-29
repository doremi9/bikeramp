require 'rails_helper'

describe Ride, type: :model do
  it { is_expected.to validate_presence_of(:start_address) }
  it { is_expected.to validate_presence_of(:destination_address) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to belong_to(:user) }

  let(:start_address) { 'Plac Europejski 2, Warszawa, Polska' }
  let(:destination_address) { 'Marii Grzegorzewskiej 4, Warszawa, Polska' }
  let(:date) { Date.yesterday }
  let(:user) do
      User.create(email: 'qwe@qwe.qwe', password: 'password', password_confirmation: 'password')
    end
  describe 'price' do
    let(:attributes) do
      {
        start_address: start_address,
        destination_address: destination_address,
        price: price,
        date: date,
        distance: 120,
        user: user
      }
    end
    
    subject { described_class.create!(attributes) }

    context 'with more than 2 digits after period' do
      let(:price) { 29.6786745 }

      it 'rounds the price to 2 digits after period' do
        expect(subject.price.to_f).to eq(29.68)
      end
    end

    context 'with 2 digits after period' do
      let(:price) { 29.67 }

      it 'does not round the price' do
        expect(subject.price.to_f).to eq(29.67)
      end
    end

    context 'with no digits after period' do
      let(:price) { 29 }

      it 'does not round the price' do
        expect(subject.price.to_f).to eq(29.0)
      end
    end
  end

  describe 'Scopes' do
    before { Timecop.freeze(Time.new(2018, 10, 26, 10, 30).utc) }
    let!(:ride_this_week1) do
      Ride.create!(
        date: Date.current,
        user: user,
        start_address: start_address,
        destination_address: destination_address,
        price: 29.67
      )
    end
    let!(:ride_this_week2) do
      Ride.create!(
        date: Date.current,
        user: user,
        start_address: start_address,
        destination_address: destination_address,
        price: 29.67
      )
    end
    let!(:ride_previous_week) do
      Ride.create!(
        date: 1.week.ago,
        user: user,
        start_address: start_address,
        destination_address: destination_address,
        price: 29.67
      )
    end
    let!(:ride_previous_month) do
      Ride.create!(
        date: 1.months.ago,
        user: user,
        start_address: start_address,
        destination_address: destination_address,
        price: 29.67
      )
    end

    after { Timecop.return }

    describe '.weekly scope' do
      it 'returns current week rides' do
        expect(described_class.weekly)
          .to contain_exactly(ride_this_week1, ride_this_week2)
        expect(described_class.weekly).not_to include(ride_previous_week)
      end
    end

    describe '.monthly scope' do
      it 'returns current month rides' do
        expect(described_class.monthly)
          .to contain_exactly(ride_this_week1, ride_this_week2, ride_previous_week)
        expect(described_class.monthly).not_to include(ride_previous_month)
      end
    end
  end
end
