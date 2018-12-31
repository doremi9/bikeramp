module API
  class Core < Grape::API
    prefix :api
    include ErrorHandlers
    default_format :json
    helpers AuthHelpers
    content_type :json, 'application/json'

    mount ::Trips::Base
    mount ::Statistics::Base
    mount ::Users::Base
    mount ::Auth::Base
  end
end
