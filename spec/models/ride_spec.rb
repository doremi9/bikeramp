require 'rails_helper'

describe Ride, type: :model do
  it { is_expected.to validate_presence_of(:start_address) }
  it { is_expected.to validate_presence_of(:destination_address) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:date) }

  let(:start_address) { 'Plac Europejski 2, Warszawa, Polska' }
  let(:destination_address) { 'Marii Grzegorzewskiej 4, Warszawa, Polska' }
  let(:date) { Date.yesterday }

  describe "price" do
    let(:attributes) do
      {
        start_address: start_address,
        destination_address: destination_address,
        price: price,
        date: date,
        distance: 120
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
end