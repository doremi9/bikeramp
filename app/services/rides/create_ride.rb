module Rides
  class CreateRide
    attr_reader :start_address, :destination_address, :price, :date

    def initialize(params)
      @start_address = params[:start_address]
      @destination_address = params[:destination_address]
      @price = params[:price]
      @date = params[:date]
    end

    def call
      Ride.create(
        start_address: start_address,
        destination_address: destination_address,
        price: price,
        date: date,
        distance: calculated_distance
      )
    end

    private

    def calculated_distance
      start_address_coordinates = Geocoder.coordinates(start_address)
      destination_coordinates = Geocoder.coordinates(destination_address)
      Geocoder::Calculations.distance_between(
        start_address_coordinates, destination_coordinates
      )
    end
  end
end
