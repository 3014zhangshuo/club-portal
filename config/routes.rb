ClubPortal::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :user

  get "/about" => 'home#about'

  root :to => 'home#index'
end
