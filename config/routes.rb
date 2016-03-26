Rails.application.routes.draw do
  resources :conversations
  resources :experiences
  resources :applications
  resources :open_jobs
  resources :companies
  resources :users

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
 get 'signout', to: 'sessions#destroy'
  get 'about', to: 'companies#about'
  get 'welcome', to: 'open_jobs#welcome'
  post 'messages', to: 'messages#create'
  post 'set_read', to: 'conversations#set_read'

  get 'current_user_open_jobs', to: 'open_jobs#current_user_open_jobs'

  root :to => "open_jobs#welcome"

  resource :session, only: [:new, :create, :destroy]

  resources :companies do
       member do
         get 'administration'
       end
  end


  resources :open_jobs do
       member do
         get 'administration'
       end
  end

  resources :users do
       member do
         get 'my_companies'
         get 'messages'
       end
  end


  resources :applications do
    post 'toggle_abandoned', on: :member
  end

  resources :companies do
    post 'add_admin', on: :member
  end


  post 'toggle_showing_abandoned',  to: 'open_jobs#toggle_showing_abandoned' 
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
