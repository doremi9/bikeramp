module Statistics
  class StatisticsAPI < API::Core
    resources :stats do
      desc 'Weekly rides'
      get '/weekly' do
        Statistics::WeeklyRidesStatisticsGenerator.new.call
      end

      desc 'Monthly rides'
      get '/monthly' do
        Statistics::MonthlyRidesStatisticsGenerator.new.call
      end
    end
  end
end