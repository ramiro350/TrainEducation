Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { 
    omniauth_callbacks: "users/omniauth_callbacks" ,
    sessions: 'users/sessions'
  }

  get 'train_model', to: 'training#train_model'
  resources :datasets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    # root to: 'usuarios/sessions#new', as: :root_login
    # get 'sign_in', to: 'usuarios/sessions#new'
    get '/user/logout', to: 'users/sessions#logout'
    # get '/usuarios/sign_out', to: 'usuarios/sessions#destroy'
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
