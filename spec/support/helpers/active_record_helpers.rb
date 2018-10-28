# frozen_string_literal: true

module Helpers
  module ActiveRecordHelpers
    def not_existing_id(klass)
      klass.maximum(:id).to_i.next
    end
  end
end
