Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end


  root :to => 'sessions#new'

 # get 'sessions/new'
 # get 'sessions/create'
 # get 'sessions/destroy'
  # resources :comments
  resources :blogs do
    resources :comments
  end

  resources :comments
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
