require 'rails_helper'

describe Ride, type: :model do
  it { is_expected.to validate_presence_of(:start_address) }
  it { is_expected.to validate_presence_of(:destination_address) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:date) }
end