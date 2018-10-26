module Statistics
  class CurrentMonthRidesGenerator
    def initialize(current_user)
      @current_user = current_user
    end
    
    def call
      user_current_month_rides_by_day.map do |date, rides_on_day|
        {
          day: formatted_date(date),
          total_distance: total_distance(rides_on_day),
          avg_ride: avg_ride(rides_on_day),
          avg_price: avg_price(rides_on_day)
        }
      end
    end

    private

    def user_current_month_rides_by_day
      @current_user.monthly_rides.order('date ASC').group_by(&:date)
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
