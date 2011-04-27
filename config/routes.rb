Sendai20::Application.routes.draw do
  get "operator/welcome"
  match 'welcome' => 'operator#welcome'
  root :to => "operator#welcome"
  
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login

  resources :opinions
  resources :sessions
  resources :users do
    member do
      get 'edit_roles'
      put 'update_roles'
    end
  end

end
