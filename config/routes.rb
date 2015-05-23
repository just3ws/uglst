require 'sidekiq/web'

# 127.0.0.1 uglst.dev
# 127.0.0.1 api.uglst.dev

Rails.application.routes.draw do
  use_doorkeeper

  resources :opportunities, only: %i(index show)

  # /status
  get '/status', to: 'status#ping'

  # /heartbeat
  get '/heartbeat.:format', to: 'heartbeat#ping', constraints: { format: 'txt' }

  get 'reports/top_viewed_user_groups.:format', to: 'reports#top_viewed_user_groups', constraints: { format: 'json' }

  namespace :happy do
    get 'hello/badge'
  end

  authenticate :user, ->(u) { Rails.env.development? || u.admin? } do
    namespace :admin, path: '/admin' do # , constraints: require_admin do
      mount Sidekiq::Web, at: 'sidekiq'
      mount PgHero::Engine, at: 'pghero'
      mount RailsAdmin::Engine, at: 'rails'
    end
  end

  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1 do
      get '/me' => 'credentials#me'
    end
  end

  # /privacy
  get 'privacy' => 'pages#privacy'

  # /terms_of_service
  get 'terms_of_service' => 'pages#terms_of_service'

  post 'awesome' => 'pages#awesome'

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
  root 'user_groups#index'
end

# == Route Map
#
#                        Prefix Verb   URI Pattern                                       Controller#Action
#                               GET    /oauth/authorize/:code(.:format)                  doorkeeper/authorizations#show
#           oauth_authorization GET    /oauth/authorize(.:format)                        doorkeeper/authorizations#new
#                               POST   /oauth/authorize(.:format)                        doorkeeper/authorizations#create
#                               PATCH  /oauth/authorize(.:format)                        doorkeeper/authorizations#update
#                               PUT    /oauth/authorize(.:format)                        doorkeeper/authorizations#update
#                               DELETE /oauth/authorize(.:format)                        doorkeeper/authorizations#destroy
#                   oauth_token POST   /oauth/token(.:format)                            doorkeeper/tokens#create
#                  oauth_revoke POST   /oauth/revoke(.:format)                           doorkeeper/tokens#revoke
#            oauth_applications GET    /oauth/applications(.:format)                     doorkeeper/applications#index
#                               POST   /oauth/applications(.:format)                     doorkeeper/applications#create
#         new_oauth_application GET    /oauth/applications/new(.:format)                 doorkeeper/applications#new
#        edit_oauth_application GET    /oauth/applications/:id/edit(.:format)            doorkeeper/applications#edit
#             oauth_application GET    /oauth/applications/:id(.:format)                 doorkeeper/applications#show
#                               PATCH  /oauth/applications/:id(.:format)                 doorkeeper/applications#update
#                               PUT    /oauth/applications/:id(.:format)                 doorkeeper/applications#update
#                               DELETE /oauth/applications/:id(.:format)                 doorkeeper/applications#destroy
# oauth_authorized_applications GET    /oauth/authorized_applications(.:format)          doorkeeper/authorized_applications#index
#  oauth_authorized_application DELETE /oauth/authorized_applications/:id(.:format)      doorkeeper/authorized_applications#destroy
#              oauth_token_info GET    /oauth/token/info(.:format)                       doorkeeper/token_info#show
#                 opportunities GET    /opportunities(.:format)                          opportunities#index
#                   opportunity GET    /opportunities/:id(.:format)                      opportunities#show
#                        status GET    /status(.:format)                                 status#ping
#                               GET    /heartbeat.:format                                heartbeat#ping {:format=>"txt"}
#                               GET    /reports/top_viewed_user_groups.:format           reports#top_viewed_user_groups {:format=>"json"}
#             happy_hello_badge GET    /happy/hello/badge(.:format)                      happy/hello#badge
#             admin_sidekiq_web        /admin/sidekiq                                    Sidekiq::Web
#                 admin_pg_hero        /admin/pghero                                     PgHero::Engine
#             admin_rails_admin        /admin/rails                                      RailsAdmin::Engine
#                     api_v1_me GET    /v1/me(.:format)                                  api/v1/credentials#me {:subdomain=>"api"}
#                       privacy GET    /privacy(.:format)                                pages#privacy
#              terms_of_service GET    /terms_of_service(.:format)                       pages#terms_of_service
#                       awesome POST   /awesome(.:format)                                pages#awesome
#                      networks GET    /networks(.:format)                               networks#index
#                               POST   /networks(.:format)                               networks#create
#                   new_network GET    /networks/new(.:format)                           networks#new
#                  edit_network GET    /networks/:id/edit(.:format)                      networks#edit
#                       network GET    /networks/:id(.:format)                           networks#show
#                               PATCH  /networks/:id(.:format)                           networks#update
#                               PUT    /networks/:id(.:format)                           networks#update
#                               DELETE /networks/:id(.:format)                           networks#destroy
#          edit_profile_account GET    /profiles/:profile_id/account/edit(.:format)      profiles/account#edit
#               profile_account PATCH  /profiles/:profile_id/account(.:format)           profiles/account#update
#                               PUT    /profiles/:profile_id/account(.:format)           profiles/account#update
#          edit_profile_private GET    /profiles/:profile_id/private/edit(.:format)      profiles/private#edit
#               profile_private PATCH  /profiles/:profile_id/private(.:format)           profiles/private#update
#                               PUT    /profiles/:profile_id/private(.:format)           profiles/private#update
#                               DELETE /profiles/:profile_id/private(.:format)           profiles/private#destroy
#           edit_profile_public GET    /profiles/:profile_id/public/edit(.:format)       profiles/public#edit
#                profile_public PATCH  /profiles/:profile_id/public(.:format)            profiles/public#update
#                               PUT    /profiles/:profile_id/public(.:format)            profiles/public#update
#                      profiles GET    /profiles(.:format)                               profiles#index
#                               POST   /profiles(.:format)                               profiles#create
#                   new_profile GET    /profiles/new(.:format)                           profiles#new
#                  edit_profile GET    /profiles/:id/edit(.:format)                      profiles#edit
#                       profile GET    /profiles/:id(.:format)                           profiles#show
#                               PATCH  /profiles/:id(.:format)                           profiles#update
#                               PUT    /profiles/:id(.:format)                           profiles#update
#                               DELETE /profiles/:id(.:format)                           profiles#destroy
#              new_user_session GET    /users/sign_in(.:format)                          devise/sessions#new
#                  user_session POST   /users/sign_in(.:format)                          devise/sessions#create
#          destroy_user_session DELETE /users/sign_out(.:format)                         devise/sessions#destroy
#                 user_password POST   /users/password(.:format)                         devise/passwords#create
#             new_user_password GET    /users/password/new(.:format)                     devise/passwords#new
#            edit_user_password GET    /users/password/edit(.:format)                    devise/passwords#edit
#                               PATCH  /users/password(.:format)                         devise/passwords#update
#                               PUT    /users/password(.:format)                         devise/passwords#update
#      cancel_user_registration GET    /users/cancel(.:format)                           devise/registrations#cancel
#             user_registration POST   /users(.:format)                                  devise/registrations#create
#         new_user_registration GET    /users/sign_up(.:format)                          devise/registrations#new
#        edit_user_registration GET    /users/edit(.:format)                             devise/registrations#edit
#                               PATCH  /users(.:format)                                  devise/registrations#update
#                               PUT    /users(.:format)                                  devise/registrations#update
#                               DELETE /users(.:format)                                  devise/registrations#destroy
#               user_group_join POST   /user_groups/:user_group_id/join(.:format)        user_groups#join
#              user_group_leave POST   /user_groups/:user_group_id/leave(.:format)       user_groups#leave
#        user_group_memberships GET    /user_groups/:user_group_id/memberships(.:format) user_groups#memberships
#                   user_groups GET    /user_groups(.:format)                            user_groups#index
#                               POST   /user_groups(.:format)                            user_groups#create
#                new_user_group GET    /user_groups/new(.:format)                        user_groups#new
#               edit_user_group GET    /user_groups/:id/edit(.:format)                   user_groups#edit
#                    user_group GET    /user_groups/:id(.:format)                        user_groups#show
#                               PATCH  /user_groups/:id(.:format)                        user_groups#update
#                               PUT    /user_groups/:id(.:format)                        user_groups#update
#                               DELETE /user_groups/:id(.:format)                        user_groups#destroy
#                          root GET    /                                                 pages#root
#
# Routes for PgHero::Engine:
#               root GET  /                             pg_hero/home#index
#            indexes GET  /indexes(.:format)            pg_hero/home#indexes
#              space GET  /space(.:format)              pg_hero/home#space
#            queries GET  /queries(.:format)            pg_hero/home#queries
#        query_stats GET  /query_stats(.:format)        pg_hero/home#query_stats
#       system_stats GET  /system_stats(.:format)       pg_hero/home#system_stats
#            explain GET  /explain(.:format)            pg_hero/home#explain
#               tune GET  /tune(.:format)               pg_hero/home#tune
#               kill POST /kill(.:format)               pg_hero/home#kill
#           kill_all POST /kill_all(.:format)           pg_hero/home#kill_all
# enable_query_stats POST /enable_query_stats(.:format) pg_hero/home#enable_query_stats
#                    POST /explain(.:format)            pg_hero/home#explain
#  reset_query_stats POST /reset_query_stats(.:format)  pg_hero/home#reset_query_stats
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
