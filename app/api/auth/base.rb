module Auth
  class Base < API::Core
    resources :auth do
      mount AuthAPI
    end
  end
end
