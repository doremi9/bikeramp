require './app/api/core'

Rails.application.routes.draw do
  #API
  mount API::Core => '/'
end
