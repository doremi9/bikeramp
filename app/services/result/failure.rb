module Result
  class Failure < Base
    def success?
      false
    end
  end
end
