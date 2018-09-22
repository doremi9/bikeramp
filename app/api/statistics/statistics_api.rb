module Statistics
  class StatisticsAPI < API::Core
    resources :stats do
      desc 'Weekly rides'
      get '/weekly' do
        Statistics::WeeklyRidesGenerator.new.call
      end

      desc 'Monthly rides'
      get '/monthly' do
        Statistics::MonthlyRidesGenerator.new.call
      end
    end
  end
end