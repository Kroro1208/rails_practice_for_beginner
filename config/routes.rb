Rails.application.routes.draw do
  root to: 'questions#index'
   #resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :questions do
    collection do
      get :solved
      get :unsolved
    end

    member do
      post :solve
    end
    
    resources :answers, only: [:create, :edit, :update, :destroy]
  end

  resources :users, only: [:index, :edit, :update]

  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :destroy]
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
