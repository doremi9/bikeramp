module Users
  class Base < API::Core
    resources :users do
      mount UsersAPI
    end
  end
end
