Rails.application.routes.draw do
  devise_for :users
  get "/", to: "pages#home", as:"root"
  #get request through home, goes through pages controller and home method, prefix is root

  get "/listings", to:"listings#index", as: "listings"

  get "/listings/new", to:"listings#new", as:"new_listing"

end
