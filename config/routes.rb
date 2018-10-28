require './app/api/core'

Rails.application.routes.draw do
  devise_for(:admin_users, ActiveAdmin::Devise.config)
  ActiveAdmin.routes(self)
  devise_for :user, controllers: { confirmations: 'confirmations' }
  # API
  mount API::Core => '/'
end
