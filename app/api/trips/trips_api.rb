module Trips
  class TripsAPI < Base
    helpers do
      params :trips_params do
        requires :start_address, type: String
        requires :destination_address, type: String
        requires :price_cents, type: Float
        requires :date, type: Date
      end
    end

    desc "Return all user's rides"
    get do
      current_user.rides.order(date: 'asc')
    end

    desc 'Create new ride'
    params do
      use :trips_params
    end

    post do
      result = Rides::CreateRide.new(params, current_user).call
      if result.success?
        result.data
      else
        error!({ message: result.message }, 403)
      end
    end

    desc "Updates user's ride"
    params do
      optional :start_address, type: String
      optional :destination_address, type: String
      optional :price_cents, type: Float
      optional :date, type: Date
    end
    patch '/:id' do
      ride = current_user.rides.find(params[:id])
      ride.update(params)
      body false
    end

    desc "Deletes user's ride"
    delete '/:id' do
      ride = current_user.rides.find(params[:id])
      ride.destroy
      body false
    end
  end
end
