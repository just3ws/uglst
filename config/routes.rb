# == Route Map (Updated 2014-06-09 13:33)
#
#                   Prefix Verb   URI Pattern                     Controller#Action
#              user_groups GET    /user_groups(.:format)          user_groups#index
#                          POST   /user_groups(.:format)          user_groups#create
#           new_user_group GET    /user_groups/new(.:format)      user_groups#new
#          edit_user_group GET    /user_groups/:id/edit(.:format) user_groups#edit
#               user_group GET    /user_groups/:id(.:format)      user_groups#show
#                          PATCH  /user_groups/:id(.:format)      user_groups#update
#                          PUT    /user_groups/:id(.:format)      user_groups#update
#                          DELETE /user_groups/:id(.:format)      user_groups#destroy
#                 profiles GET    /profiles(.:format)             profiles#index
#                          POST   /profiles(.:format)             profiles#create
#              new_profile GET    /profiles/new(.:format)         profiles#new
#             edit_profile GET    /profiles/:id/edit(.:format)    profiles#edit
#                  profile GET    /profiles/:id(.:format)         profiles#show
#                          PATCH  /profiles/:id(.:format)         profiles#update
#                          PUT    /profiles/:id(.:format)         profiles#update
#                          DELETE /profiles/:id(.:format)         profiles#destroy
#         new_user_session GET    /users/sign_in(.:format)        devise/sessions#new
#             user_session POST   /users/sign_in(.:format)        devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)       devise/sessions#destroy
#            user_password POST   /users/password(.:format)       devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)   devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)  devise/passwords#edit
#                          PATCH  /users/password(.:format)       devise/passwords#update
#                          PUT    /users/password(.:format)       devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)         devise/registrations#cancel
#        user_registration POST   /users(.:format)                devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)        devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)           devise/registrations#edit
#                          PATCH  /users(.:format)                devise/registrations#update
#                          PUT    /users(.:format)                devise/registrations#update
#                          DELETE /users(.:format)                devise/registrations#destroy
#                     root GET    /                               user_groups#index
#

Rails.application.routes.draw do

  resources :user_groups
  resources :profiles

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'user_groups#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
