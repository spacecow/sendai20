Sendai20::Application.routes.draw do
  resources :resets, :only => [:new,:create]

  resources :locales, :only => [:create,:update]
  resources :translations, :only => [:index,:create] do
    collection do
      delete 'delete'
    end
  end

  get "operator/welcome"
  get "operator/scrollup"
  get "operator/movie"
  match 'welcome' => 'operator#movie'
  match 'scrollup' => 'operator#scrollup'
  match 'movie' => 'operator#movie'
  
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

  root :to => "operator#movie"
end
