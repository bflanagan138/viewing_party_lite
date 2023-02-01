Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :users, only: [:create, :show] do
    resources :discover, only: :index
    resources :movies, only: :index
  end

  get '/register', to: 'users#new'


end
