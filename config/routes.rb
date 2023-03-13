Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :companies, except: :destroy
  resources :musicians, except: :destroy
  resources :companies do
    resources :events, only: %i[create new show edit update destroy]
  end
  resources :events, only: %i[index show]
  resources :proposals, except: %i[ show edit ]


  get "profile_musician", to: "pages#profile_musician"
  get "profile_company", to: "pages#profile_company"


  resources :chatrooms, only: :show
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end


  # , only: %i[show index new]

    # ---- pseudocode----
  # proposal criada quando cada musico se candidata!
  # COMPANY: recebe notificação de Proposal criada
  # Abrimos a possibilidade de abrir um chat.
  # caso a COMPANY recusar. A proposta é recusada e seu atributo winner -> false
  # Musico: recebe notificação de recusa
  # DELETAR INSTANCIA DE PROPOSAL

  # Se COMPANY aceitar. winner -> true
  # Musico: recebe notificação de aceito
  # INSERIR EVENT -> myEvents do Musician
  # INSERIR no event do COMPANY,(my Events COMPANY), link pro profile do Musician
  # -------------------

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
