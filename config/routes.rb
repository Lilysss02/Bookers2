Rails.application.routes.draw do
  root 'home#top'
  get 'about' => 'home#about'
  devise_for :users
  resources :books
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
