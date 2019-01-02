require 'rails_helper'

describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:password_confirmation) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { is_expected.to have_many(:rides) }
  it { is_expected.to have_many(:weekly_rides) }
  it { is_expected.to have_many(:monthly_rides) }
  it { is_expected.to have_db_column(:avatar) }
  it { is_expected.to have_many(:invoices) }

  let(:first_name) { "John" }
  let(:last_name)  { "Doe"  }
  let(:user) { create(:user, first_name: first_name, last_name: last_name) }

  describe 'name' do
    it 'concatenates first name and last name' do
      expect(user.name).to eq("John Doe")
    end
  end
end
