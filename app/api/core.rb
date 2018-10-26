module API
  class Core < Grape::API
    prefix :api
    include ErrorHandlers
    helpers AuthHelpers
    default_format :json
    content_type :json, 'application/json'

    mount ::Trips::Base
    mount ::Statistics::Base
    mount ::Users::Base
  end
end
