module Rides
  class CreateRide
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
        distance: Rides::DistanceCalculator.calculate(start_address, destination_address)
      )
    end

    private

    attr_reader :start_address, :destination_address, :price, :date
  end
end
