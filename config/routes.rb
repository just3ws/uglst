require 'sidekiq/web'

# 127.0.0.1 uglst.dev
# 127.0.0.1 api.uglst.dev

Rails.application.routes.draw do
  resources :opportunities, only: %i(index show)

  # /status
  get '/status', to: 'status#ping'

  # /heartbeat
  get '/heartbeat.:format', to: 'heartbeat#ping', constraints: { format: 'txt' }

  get 'reports/top_viewed_user_groups.:format', to: 'reports#top_viewed_user_groups', constraints: { format: 'json' }

  namespace :happy do
    get 'hello/badge'
  end

  authenticate :user, ->(u) { u.admin? } do
    namespace :admin, path: '/admin' do # , constraints: require_admin do
      mount Sidekiq::Web => '/sidekiq'
    end
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  namespace :api, path: '/', constraints: { subdomain: 'api' } do
  end

  # /privacy
  get 'privacy' => 'pages#privacy'

  # /terms_of_service
  get 'terms_of_service' => 'pages#terms_of_service'

  # /networks
  resources :networks

  resources :profiles, except: %(edit update destroy) do
    scope module: :profiles do
      # /profiles/:id/account
      resource :account, only: %i(edit update)

      # /profiles/:id/private
      resource :private, only: %i(edit update destroy)

      # /profiles/:id/public
      resource :public, only: %i(edit update)
    end
  end

  # /users
  devise_for :users

  resources :user_groups do
    # /user_groups/:id/join
    post '/join' => 'user_groups#join'

    # /user_groups/:id/leave
    post '/leave' => 'user_groups#leave'

    # /user_groups/:id/memberships
    get '/memberships' => 'user_groups#memberships'
  end

  # /
  root 'pages#root'
end

# == Route Map
#
#                   Prefix Verb   URI Pattern                                       Controller#Action
#                   status GET    /status(.:format)                                 status#ping
#                          GET    /heartbeat.:format                                heartbeat#ping {:format=>"txt"}
#                          GET    /reports/top_viewed_user_groups.:format           reports#top_viewed_user_groups {:format=>"json"}
#        happy_hello_badge GET    /happy/hello/badge(.:format)                      happy/hello#badge
#            admin_sidekiq        /admin/sidekiq                                    Sidekiq::Web
#              rails_admin        /admin                                            RailsAdmin::Engine
#                  privacy GET    /privacy(.:format)                                pages#privacy
#         terms_of_service GET    /terms_of_service(.:format)                       pages#terms_of_service
#                 networks GET    /networks(.:format)                               networks#index
#                          POST   /networks(.:format)                               networks#create
#              new_network GET    /networks/new(.:format)                           networks#new
#             edit_network GET    /networks/:id/edit(.:format)                      networks#edit
#                  network GET    /networks/:id(.:format)                           networks#show
#                          PATCH  /networks/:id(.:format)                           networks#update
#                          PUT    /networks/:id(.:format)                           networks#update
#                          DELETE /networks/:id(.:format)                           networks#destroy
#     edit_profile_account GET    /profiles/:profile_id/account/edit(.:format)      profiles/account#edit
#          profile_account PATCH  /profiles/:profile_id/account(.:format)           profiles/account#update
#                          PUT    /profiles/:profile_id/account(.:format)           profiles/account#update
#     edit_profile_private GET    /profiles/:profile_id/private/edit(.:format)      profiles/private#edit
#          profile_private PATCH  /profiles/:profile_id/private(.:format)           profiles/private#update
#                          PUT    /profiles/:profile_id/private(.:format)           profiles/private#update
#                          DELETE /profiles/:profile_id/private(.:format)           profiles/private#destroy
#      edit_profile_public GET    /profiles/:profile_id/public/edit(.:format)       profiles/public#edit
#           profile_public PATCH  /profiles/:profile_id/public(.:format)            profiles/public#update
#                          PUT    /profiles/:profile_id/public(.:format)            profiles/public#update
#                 profiles GET    /profiles(.:format)                               profiles#index
#                          POST   /profiles(.:format)                               profiles#create
#              new_profile GET    /profiles/new(.:format)                           profiles#new
#             edit_profile GET    /profiles/:id/edit(.:format)                      profiles#edit
#                  profile GET    /profiles/:id(.:format)                           profiles#show
#                          PATCH  /profiles/:id(.:format)                           profiles#update
#                          PUT    /profiles/:id(.:format)                           profiles#update
#                          DELETE /profiles/:id(.:format)                           profiles#destroy
#         new_user_session GET    /users/sign_in(.:format)                          devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                          devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                         devise/sessions#destroy
#            user_password POST   /users/password(.:format)                         devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)                     devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)                    devise/passwords#edit
#                          PATCH  /users/password(.:format)                         devise/passwords#update
#                          PUT    /users/password(.:format)                         devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                           devise/registrations#cancel
#        user_registration POST   /users(.:format)                                  devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                          devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                             devise/registrations#edit
#                          PATCH  /users(.:format)                                  devise/registrations#update
#                          PUT    /users(.:format)                                  devise/registrations#update
#                          DELETE /users(.:format)                                  devise/registrations#destroy
#          user_group_join POST   /user_groups/:user_group_id/join(.:format)        user_groups#join
#         user_group_leave POST   /user_groups/:user_group_id/leave(.:format)       user_groups#leave
#   user_group_memberships GET    /user_groups/:user_group_id/memberships(.:format) user_groups#memberships
#              user_groups GET    /user_groups(.:format)                            user_groups#index
#                          POST   /user_groups(.:format)                            user_groups#create
#           new_user_group GET    /user_groups/new(.:format)                        user_groups#new
#          edit_user_group GET    /user_groups/:id/edit(.:format)                   user_groups#edit
#               user_group GET    /user_groups/:id(.:format)                        user_groups#show
#                          PATCH  /user_groups/:id(.:format)                        user_groups#update
#                          PUT    /user_groups/:id(.:format)                        user_groups#update
#                          DELETE /user_groups/:id(.:format)                        user_groups#destroy
#                     root GET    /                                                 pages#root
#              ahoy_engine        /ahoy                                             Ahoy::Engine
#
# Routes for RailsAdmin::Engine:
#   dashboard GET         /                                      rails_admin/main#dashboard
#       index GET|POST    /:model_name(.:format)                 rails_admin/main#index
#         new GET|POST    /:model_name/new(.:format)             rails_admin/main#new
#      export GET|POST    /:model_name/export(.:format)          rails_admin/main#export
# bulk_delete POST|DELETE /:model_name/bulk_delete(.:format)     rails_admin/main#bulk_delete
# bulk_action POST        /:model_name/bulk_action(.:format)     rails_admin/main#bulk_action
#        show GET         /:model_name/:id(.:format)             rails_admin/main#show
#        edit GET|PUT     /:model_name/:id/edit(.:format)        rails_admin/main#edit
#      delete GET|DELETE  /:model_name/:id/delete(.:format)      rails_admin/main#delete
# show_in_app GET         /:model_name/:id/show_in_app(.:format) rails_admin/main#show_in_app
#
# Routes for Ahoy::Engine:
# visits POST /visits(.:format) ahoy/visits#create
# events POST /events(.:format) ahoy/events#create
#
