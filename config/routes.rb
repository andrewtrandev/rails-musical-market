Rails.application.routes.draw do
  devise_for :users
  get "/", to: "pages#home", as:"root"
  #get request through home, goes through pages controller and home method, prefix is root

  get "/listings", to:"listings#index", as: "listings"

  get "/listings/new", to:"listings#new", as:"new_listing"

  post "/listings", to:"listings#create"

  get "/listings/:id", to:"listings#show", as:"listing"

  get "/listings/:id/edit", to:"listings#edit", as:"edit_listing"

  put "/listings/:id", to:"listings#update"
  #good to have put patch even though form uses the patch method

  patch "/listings/:id", to: "listings#update"

  delete "/listings/:id", to: "listings#destroy"

end
