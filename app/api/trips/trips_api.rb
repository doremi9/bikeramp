module Trips
  class TripsAPI < Base
    helpers do
      params :trips_params do
        requires :start_address, type: String
        requires :destination_address, type: String
        requires :price, type: Float
        requires :date, type: Date
      end
    end

    desc 'Create new ride'
    params do
      use :trips_params
    end

    post do
      result = Rides::CreateRide.new(params, current_user).call
      if result.success?
        status :ok
      else
        error!({ message: result.message }, 403)
      end
    end
  end
end
