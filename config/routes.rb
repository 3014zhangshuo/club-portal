ClubPortal::Application.routes.draw do
  get "profile/create"

  get "profile/update"

  get "profile/show"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :user

  get "/about" => 'home#about'

  root :to => 'home#index'
end
