ClubPortal::Application.routes.draw do
  devise_for :user

  get "/about" => 'home#about'

  root :to => 'home#index'
end
