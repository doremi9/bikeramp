module Rides
  class DistanceCalculator
    def self.calculate(start_address, destination_address)
      start_address_coordinates = Geocoder.coordinates(start_address)
      destination_coordinates = Geocoder.coordinates(destination_address)
      Geocoder::Calculations.distance_between(
        start_address_coordinates, destination_coordinates
      )
    end
  end
end