Rails.application.routes.draw do
  
  get 'listings/index'

  get 'listings/edit'

  get 'listings/new'

  get 'listings/show'

  root 'welcome#index'
  
  resources :users

  resources :listings

  get '/sessions/new', to: "sessions#new", as: 'login'
  
  post '/sessions', to: 'sessions#create', as: 'login_user'

  post '/sign_out', to: 'sessions#destroy'

  get '/listings/heatmap', to: 'listings#heatmap', as: 'heatmap'

end

###########################################################
####         When in doubt, rake those routes          ####
###########################################################
# listings_index GET    /listings/index(.:format)    listings#index
#  listings_edit GET    /listings/edit(.:format)     listings#edit
#   listings_new GET    /listings/new(.:format)      listings#new
#  listings_show GET    /listings/show(.:format)     listings#show
#           root GET    /                            welcome#index
#          users GET    /users(.:format)             users#index
#                POST   /users(.:format)             users#create
#       new_user GET    /users/new(.:format)         users#new
#      edit_user GET    /users/:id/edit(.:format)    users#edit
#           user GET    /users/:id(.:format)         users#show
#                PATCH  /users/:id(.:format)         users#update
#                PUT    /users/:id(.:format)         users#update
#                DELETE /users/:id(.:format)         users#destroy
#       listings GET    /listings(.:format)          listings#index
#                POST   /listings(.:format)          listings#create
#    new_listing GET    /listings/new(.:format)      listings#new
#   edit_listing GET    /listings/:id/edit(.:format) listings#edit
#        listing GET    /listings/:id(.:format)      listings#show
#                PATCH  /listings/:id(.:format)      listings#update
#                PUT    /listings/:id(.:format)      listings#update
#                DELETE /listings/:id(.:format)      listings#destroy
#          login GET    /sessions/new(.:format)      sessions#new
#     login_user POST   /sessions(.:format)          sessions#create
#       sign_out POST   /sign_out(.:format)          sessions#destroy










