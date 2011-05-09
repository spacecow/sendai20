Sendai20::Application.routes.draw do
  get "operator/welcome"
  get "operator/welcome_up"
  get "operator/scrollup"
  match 'welcome' => 'operator#welcome'
  match 'welcome_up' => 'operator#welcome_up'
  match 'scrollup' => 'operator#scrollup'
  root :to => "operator#welcome"
  
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login

  resources :opinions, :only => [:create,:update]
  resources :sessions
  resources :users do
    member do
      get 'edit_roles'
      put 'update_roles'
    end
  end

end
