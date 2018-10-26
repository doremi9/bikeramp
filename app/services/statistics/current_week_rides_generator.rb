module Statistics
  class CurrentWeekRidesGenerator
    def initialize(current_user)
      @current_user = current_user
    end

    def call
      {
        total_distance: total_distance,
        total_price: total_price
      }
    end

    private

    def total_distance
      "#{user_current_week_rides.map(&:distance).sum}km"
    end

    def total_price
      "#{user_current_week_rides.map(&:price).sum}PLN"
    end

    def user_current_week_rides
      @current_user.weekly_rides
    end
  end
end
