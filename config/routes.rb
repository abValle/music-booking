Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :companies, except: :destroy
  resources :musicians, except: :destroy

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
