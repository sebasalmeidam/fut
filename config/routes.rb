Rails.application.routes.draw do
  
  
  resources :fifa17, controller: 'api_players', only: [:index, :show]

  root 'api_players#index'
  

  devise_for :users

  devise_scope :user do
    get 'iniciar_sesion', to: 'devise/sessions#new'
    get 'registro', to: 'devise/registrations#new'
  end

  devise_scope :user do
    authenticated :user do
      root 'players#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end 

  resources :users do 
    resources :players do
      member do
        post 'edit_mail'
        get 'edit_mail'
      end
    end
  end

  resources :players do
    member do
      post 'edit_buyed'
      get 'edit_buyed'
      post 'edit_track'
      get 'edit_track'
    end
    resources :prices
    resources :sales, only: [:new, :create, :destroy] 
  end

  

  get 'list' => 'players#player_list'
  get 'prices' => 'players#update_prices'

  require 'api_constraints'

  namespace :api, defaults: {format: :json} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :players, only: [:index, :show, :create, :update, :destroy] do
        member do
          post 'api_edit_mail'
          get 'api_edit_mail'
          post 'api_edit_buyed'
          get 'api_edit_buyed'
        end 
      end
      resources :sessions, :only => [:create, :destroy]
      resources :users, only: [:show, :update, :create]
    end
  end


 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
