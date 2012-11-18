P2pBookSharing::Application.routes.draw do
  resources :deals
  resources :collections do
    resources :deals
  end
  resources :sessions
  resources :password_resets
  resources :users do
    collection do
      get 'guide'
    end
    resources :deals
    resources :collections do
      collection do
        get 'search'
      end
    end
  end
  resources :villages do
    member do
      get :collections
    end
  end
  
  match "/cities" => 'villages#si_list', :as => "cities"
  match "/:si/list" => 'villages#gu_list', :as => "gu_list"
  match "/:si/:gu/list" => 'villages#dong_list', :as => "dong_list"
  match "/:si/:gu/:dong/list" => 'villages#village_list', :as => "village_list"

  get "logout"  => "sessions#destroy", :as => "logout"
  get "login"   => "sessions#new", :as => "login"
  get "signup"  => "users#new", :as => "signup"
  get "my_page" => "users#my_page", :as => "my_page"

  resources :book_urls

  resources :list_pages

  resources :books

  root :to => 'villages#si_list'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end