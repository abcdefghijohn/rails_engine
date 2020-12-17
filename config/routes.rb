# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#find'
        get '/find_all', to: 'search#find_all'
      end
      namespace :items do
        get '/find', to: 'search#find'
        get '/find_all', to: 'search#find_all'
        get '/:id/merchants',to: 'search#show'
      end
      resources :merchants
      resources :items
    end
  end
end
