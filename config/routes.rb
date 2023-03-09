Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :musicians, except: :destroy, do 
    resource :events, only %i[show index]
  resources :companies, do
    resources :events, only: %i[new create show destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
