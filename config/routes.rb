Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end
  root to: 'todos#index'
  resources :todos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
