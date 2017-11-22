Rails.application.routes.draw do
  root "users#index"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  get "matches" => "matches#index"
  get 'matches/new' => "matches#new", as: :new_match
  get "matches" => "matches#show"

  post "matches" => "matches#create"
  get 'matches/:id/edit' => 'matches#edit', as: :edit_match

  patch "matches/:id" => "matches#update"

  delete "matches/:id" => "matches#destroy"
end
