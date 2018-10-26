require 'support/helpers/request_helpers'

RSpec.configure do |config|
  config.include Helpers::RequestHelpers, type: :request
  config.include Helpers::AuthHelpers, type: :request
end

