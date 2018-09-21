module Rides
  class CurrentWeekRidesQuery
    def call
      {
        total_distance: total_distance,
        total_price: total_price
      }
    end

    private

    def total_distance
      "#{current_week_rides.map(&:distance).sum}km"
    end

    def total_price
      "#{current_week_rides.map(&:price).sum}PLN"
    end

    def current_week_rides
      @current_week_rides ||= Ride.where(date: current_week)
    end

    def current_week
      Date.current.beginning_of_week..Date.current.end_of_week
    end
  end
end