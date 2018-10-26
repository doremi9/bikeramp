require './app/api/core'

Rails.application.routes.draw do
  devise_for :user, controllers: { confirmations: 'confirmations' }
  # API
  mount API::Core => '/'
end
