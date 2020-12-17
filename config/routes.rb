# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/search/find_one', to: 'search#find_one'
        get '/search/find_all', to: 'search#find_all'
      end
      resources :merchants
      resources :items
    end
  end
end
