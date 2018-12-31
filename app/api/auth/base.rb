module Auth
  class Base < API::Core
    namespace :auth do
      mount AuthAPI
    end
  end
end
