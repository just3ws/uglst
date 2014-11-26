require 'sidekiq/web'

# 127.0.0.1 uglst.dev
# 127.0.0.1 api.uglst.dev

Rails.application.routes.draw do
  get '/status',            to: 'status#ping'
  get '/heartbeat.:format', to: 'heartbeat#ping', constraints: { format: 'txt' }

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  namespace :api, path: '/', constraints: { subdomain: 'api' } do
  end

  get 'pages/privacy'
  get 'pages/terms_of_service'

  resources :networks
  resources :profiles
  devise_for :users

  resources :user_groups do
    post '/join'        => 'user_groups#join'
    post '/leave'       => 'user_groups#leave'
    get '/memberships' => 'user_groups#memberships'
  end

  root 'pages#root'
end

# == Route Map
#
