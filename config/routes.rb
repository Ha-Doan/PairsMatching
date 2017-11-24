Rails.application.routes.draw do
  root "users#index"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  match 'users/make_pairs', to: 'users#make_pairs', via: [:get, :post]
end
