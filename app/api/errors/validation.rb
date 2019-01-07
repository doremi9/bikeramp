module Errors
  module Validation
    class ValidationError < StandardError
      attr_accessor :errors

      def initialize(errors = nil)
        super(nil)
        self.errors = errors
      end
    end
  end
end
