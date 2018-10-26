module Rides
  class CreateRide < ApplicationService
    def initialize(params, user)
      @start_address = params[:start_address]
      @destination_address = params[:destination_address]
      @price = params[:price]
      @date = params[:date]
      @user = user
    end

    def call
      ride = Ride.new(
        start_address: @start_address,
        destination_address: @destination_address,
        price: @price,
        date: @date,
        user: @user,
        distance: Rides::DistanceCalculator.calculate(@start_address, @destination_address)
      )
      ride.save ? success(data: ride) : failure(message: ride.errors.full_messages)
    end
  end
end
