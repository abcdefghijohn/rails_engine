# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#find'
        get '/find_all', to: 'search#find_all'
        get '/:id/items', to: 'search#show'
        get '/most_revenue', to: 'biz_int#most_revenue'
        get '/most_items', to: 'biz_int#most_items'
      end
      namespace :items do
        get '/find', to: 'search#find'
        get '/find_all', to: 'search#find_all'
        get '/:id/merchants',to: 'search#show'
      end
      resources :merchants
      resources :items
      get '/revenue', to: 'biz_int#revenue_dates'
    end
  end
end
