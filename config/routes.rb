Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'
  resources :objets do
    resources :encheres
    collection do
      get 'ventes'
      get 'achats'
    end
  end


  resources :utilisateurs do
    resources :commentaires
  end
  resources :categories



  #rename path for session (create new session or pagge for new session = login, delete session = logout)
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'home#index'
end
