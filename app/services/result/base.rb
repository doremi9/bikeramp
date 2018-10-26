module Result
  class Base < ApplicationService
    attr_reader :data, :message

    def initialize(data:, message:)
      @data    = data
      @message = message
    end

    def success?
      raise NotImplementedError
    end

    def failure?
      !success?
    end
  end
end
