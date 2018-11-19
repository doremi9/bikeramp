module Statistics
  class MonthlyRidesGenerator < ApplicationService
    def initialize(current_user)
      @current_user = current_user
    end

    def call
      Ride.find_by_sql(sql) do |row|
        { month: row.month, total_price: row.total_price, total_distance: row.total_distance }
      end
    end

    private

    def sql
      <<-SQL
        SELECT SUM(price_cents) as total_price,
          SUM(distance) as total_distance,
          TO_CHAR(date, 'YYYY-MM') as month
        FROM Rides
        WHERE user_id = #{@current_user.id}
        GROUP BY month
      SQL
    end
  end
end
