module Users
  class Base < API::Core
    resources :users do
      before { authenticate_user! }
      mount UsersAPI
    end
  end
end
