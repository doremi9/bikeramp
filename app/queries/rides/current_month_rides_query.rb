module Rides
  class CurrentMonthRidesQuery
    def call
      Ride.where(date: current_month).group_by{ |r| r.date.to_date }.map do |date, rides_on_date|
        total_distance = rides_on_date.map(&:distance).sum
        avg_distance   = total_distance / rides_on_date.size
        total_price    = rides_on_date.map(&:price).sum
        avg_price      = total_price / rides_on_date.size
        { day: date, total_distance: total_distance, avg_ride: avg_distance, avg_price: avg_price }
      end
    end

    private

    def current_month
      DateTime.current.beginning_of_month..DateTime.current.end_of_month
    end
  end
end