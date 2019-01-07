module Invoices
  class Base < API::Core
    resources :invoices do
      before { authenticate_user! }
      mount InvoicesAPI
    end
  end
end