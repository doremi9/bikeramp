class JsonWebToken
  class << self
    def issue_token(payload)
      payload[:exp] = 24.hours.from_now.to_i
      JWT.encode(payload, ENV['RAILS_SECRET'])
    end

    def decode(token)
      begin
        JWT.decode(token, ENV['RAILS_SECRET'])[0]
      rescue
        false
      end
    end
  end
end
