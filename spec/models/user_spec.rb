require 'rails_helper'

describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:password_confirmation) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it do
    is_expected.to validate_numericality_of(:phone_number)
      .only_integer.on(:update)
  end
  it { is_expected.to validate_length_of(:phone_number).is_equal_to(9).on(:update) }
  it { is_expected.to have_many(:rides) }
  it { is_expected.to have_many(:weekly_rides) }
  it { is_expected.to have_many(:monthly_rides) }
  it { is_expected.to have_db_column(:facebook_url) }
  it { is_expected.to have_db_column(:twitter_url) }
  it { is_expected.to have_db_column(:linked_in_url) }
  it { is_expected.to have_db_column(:hourly_rate) }
  it { is_expected.to have_db_column(:rides_count) }
  it { is_expected.to have_many(:invoices) }

  describe 'name' do
    let(:first_name) { 'John' }
    let(:last_name)  { 'Doe'  }
    let(:user) { create(:user, first_name: first_name, last_name: last_name) }
    
    it 'concatenates first name and last name' do
      expect(user.name).to eq('John Doe')
    end
  end

  describe 'rides_count' do
    let(:user) { create(:user) }

    specify 'updates rides count in DB' do
      user.rides.create(ride_params)
      expect(user.rides.size).to eq(1)
      user.rides.create(ride_params)
      expect(user.rides.size).to eq(2)
      user.rides.last.destroy
      expect(user.rides.size).to eq(1)
    end
  end

  def ride_params
    {
      start_address: 'Plac Europejski 2, Warszawa',
      destination_address: 'Aleje Jerozolimskie 10, Warszawa',
      price_cents: 1000.00,
      date: Date.current
    }
  end
end
