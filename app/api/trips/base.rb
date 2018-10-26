module Trips
  class Base < API::Core
    resources :trips do
      before { authenticate_user! }
      mount TripsAPI
    end
  end
end
