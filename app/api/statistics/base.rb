module Statistics
  class Base < API::Core
    resources :stats do
      before { authenticate_user! }
      mount StatisticsAPI
    end
  end
end
