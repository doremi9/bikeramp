module Helpers
  module RequestHelpers
    def response_body
      @response_body ||= JSON.parse(response.body, sybmbolize_names: true)
    end
  end

  module AuthHelpers
    def auth_headers(user)
      token = JsonWebToken.issue_token(user_id: user.id)
      {
        'Authorization': "Bearer #{token}"
      }
    end
  end
end
