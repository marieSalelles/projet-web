Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'
  resources :objets, :constraints => { :id => /[0-9]+(\%7C[0-9]+)*/ } do
    resources :encheres
    collection do
      get 'ventes'
      get 'achats'
    end
  end


  resources :utilisateurs, :constraints => { :id => /[0-9]+(\%7C[0-9]+)*/ } do
    resources :commentaires
  end
  resources :categories, :constraints => { :id => /[0-9]+(\%7C[0-9]+)*/ }



  #rename path for session (create new session or pagge for new session = login, delete session = logout)
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'home#index'
end
