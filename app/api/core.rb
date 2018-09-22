module API
  class Core < Grape::API
    default_format :json
    prefix :api
    content_type :json, 'application/json'

    mount ::Trips::Base
    mount ::Statistics::Base
  end
end