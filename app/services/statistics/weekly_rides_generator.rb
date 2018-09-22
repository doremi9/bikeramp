module Statistics
  class WeeklyRidesGenerator
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
      @current_week_rides ||= RidesQuery.new.rides_weekly
    end
  end
end