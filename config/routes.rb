Rails.application.routes.draw do
  get 'mailbox/index'

  root 'static_pages#home'
  get 'home' => 'static_pages#home'  # with dieses
  get 'about' => 'static_pages#about' 
  get 'contact' => 'static_pages#contact'
  get 'charter' => 'static_pages#charter'
  get 'services' => 'static_pages#services'
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  get 'users/excel' => 'users#export_excel'
  resources :users
  resources :users do
     member do
        get :accept
     end
  end 
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :conversations do 
      member do
          post :reply
          post :trash
          post :untrash
      end
  end
  get 'mailbox' => 'conversations#index'
  get 'organizations/auto_complete' => 'organizations#auto_complete'
  get 'organizations/list' => 'organizations#list'
  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
  delete 'signout' => 'sessions#destroy'

  get 'profile' => 'users#show' 
    
  ## Portfolio pages.
  ## For now, is in static mode. one page is hardcoded.
  ## Not the will to do a full CRUD stack for this, not for mr. carrel.
  ### But will do later
  get 'portfolio_animals' => 'portfolio#animals'
  get 'portfolio_environment' => 'portfolio#environment'
  get 'portfolio_health_hygiene' => 'portfolio#health_hygiene'
  get 'portfolio_education' => 'portfolio#education'
  get 'portfolio_poverty' => 'portfolio#poverty'
  get 'portfolio_infrastructure' => 'portfolio#infrastructure'
  ## sub items
  get 'education_rota' => 'portfolio#education_rota'
  get 'education_barefoot_college' => 'portfolio#education_bf'
  get 'health_handicap_international' => 'portfolio#health_hi'
  get 'health_medecins_sans_frontieres' => 'portfolio#health_msf'
  get 'infrastructure_habitat_for_humanity' => 'portfolio#infra_hfh'
  get 'poverty_acumen' => 'portfolio#poverty_acumen'
  get 'poverty_brac' => 'portfolio#poverty_brac'
  get 'poverty_international_rescue_committee' => 'portfolio#poverty_irc'
  get 'poverty_mercy_corps' => 'portfolio#poverty_mercy_corps'
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
