module Statistics
  class StatisticsAPI < Base
    desc 'Returns rides from current week for user'
    get '/current_week' do
      rides = current_user.weekly_rides.order(date: 'asc')
      rides.map do |ride|
        { 
          id: ride.id,
          start_address: ride.start_address,
          destination_address: ride.destination_address,
          distance: ride.distance,
          price: ride.price.to_f,
          date: ride.date
        }
      end
    end

    desc 'Returns rides from current month for user'
    get '/current_month' do
      Statistics::CurrentMonthRidesGenerator.new(current_user).call
    end

    desc "Returns all user's rides grouped by week"
    get '/weekly' do
      current_user.rides.order(date: 'asc').group_by do |ride|
        ride.date.beginning_of_week
      end
    end

    desc "Returns all user's rides grouped by month"
    get '/monthly' do
      Statistics::MonthlyRidesGenerator.new(current_user).call
    end
  end
end
