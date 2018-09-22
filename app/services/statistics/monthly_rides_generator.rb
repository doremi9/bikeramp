module Statistics
  class MonthlyRidesGenerator
    def call
      generate_monthly_stats
    end

    private

    def generate_monthly_stats
      current_month_rides.map do |date, rides_on_day|
        {
          day: formatted_date(date),
          total_distance: total_distance(rides_on_day),
          avg_ride: avg_ride(rides_on_day),
          avg_price: avg_price(rides_on_day)
        }
      end
    end

    def current_month_rides
      RidesQuery.new.rides_monthly
    end

    def formatted_date(date)
      date.strftime("%B, #{date.day.ordinalize}")
    end

    def total_distance(rides)
      "#{daily_distance(rides)}km"
    end

    def avg_ride(rides)
      "#{daily_distance(rides) / rides.size}km"
    end

    def daily_distance(rides)
      rides.map(&:distance).sum
    end

    def total_price(rides)
      rides.map(&:price).sum
    end

    def avg_price(rides)
      "#{total_price(rides) / rides.size}PLN"
    end
  end
end
