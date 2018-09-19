class Ride < ApplicationRecord
  validates_presence_of :start_address, :destination_address, :price, :date
end