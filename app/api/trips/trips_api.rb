module Trips
  class TripsAPI < API::Core
    helpers do
      params :trips_params do
        requires :start_address, type: String
        requires :destination_address, type: String
        requires :price, type: Float
        requires :date, type: Date
      end
    end

    resources :trips do
      params do
        use :trips_params
      end
      desc 'Creates new ride'
      post do
        Rides::CreateRide.new(params).call
      end
    end
  end
end