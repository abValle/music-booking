Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :musicians, except: :destroy
  resources :companies, except: :index do
    resources :events, only: %i[new create show]
  end
  resources :events, only: :destroy

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
