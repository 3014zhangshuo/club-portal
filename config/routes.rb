ClubPortal::Application.routes.draw do

  resource :profile, :only => [:update, :create]
  match '/profile/:id' => 'profiles#show', :as => 'show_profile', :via => :get

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :user

  get "/about" => 'home#about'

  root :to => 'home#index'
end
