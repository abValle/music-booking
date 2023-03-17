Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :companies, except: :destroy
  resources :musicians, except: :destroy
  resources :companies do
    resources :events, only: %i[create new show edit update destroy]
  end
  resources :events, only: %i[index show] do
    resources :proposals, only: %i[new create]
  end
  resources :proposals, only: %i[index destroy]
  # show do proposal é igual ao chatroom!!
  # post 'proposals', to: 'proposals#create', as: 'create_proposal'

  get "profile_musician", to: "pages#profile_musician"
  get "profile_company", to: "pages#profile_company"
  get "refuse_proposal", to: "proposals#refuse_proposal"
  get "accept_proposal", to: "proposals#accept_proposal"
  get "cancel_proposal", to: "proposals#cancel_proposal"


  resources :proposals, only: :show do
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
