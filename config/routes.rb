Rails.application.routes.draw do
  
  root 'welcome#index'
  resources :users
end

###########################################################
####         When in doubt, rake those routes          ####
###########################################################
#   Prefix Verb   URI Pattern               Controller#Action
#      root GET    /                         welcome#index
#     users GET    /users(.:format)          users#index
#           POST   /users(.:format)          users#create
#  new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#      user GET    /users/:id(.:format)      users#show
#           PATCH  /users/:id(.:format)      users#update
#           PUT    /users/:id(.:format)      users#update
#           DELETE /users/:id(.:format)      users#destroy