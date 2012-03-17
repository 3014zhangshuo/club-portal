ClubPortal::Application.routes.draw do

  resources :clubs, :except => [:destroy] do
    resources :memberships
  end
  match ":permalink/home" => 'clubs#homepage', :as => 'club_homepage', :via => :get
  match ":permalink/manage_dashboard" => 'clubs#manage_dashboard', :as => 'club_manage_dashboard', :via => :get

  resource :profile, :only => [:update, :create, :edit]
  #match '/profiles/:id' => 'profiles#show', :as => 'show_profile', :via => :get

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :user

  get "/about" => 'home#about'
  root :to => 'home#index'
end
