AnnuitCoeptis::Application.routes.draw do
  resources :comments

  resources :messages

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :research, only: [:index, :create]
  match 'dashboard' => 'static_pages#dashboard', :format => false
  match 'learn' => 'static_pages#learn', :format => false
  match 'learn/leagues' => 'static_pages#learnleagues', :format => false 
  match 'learn/leagues/view' => 'static_pages#learnleagueview', :format => false 
  match 'learn/leagues/edit' => 'static_pages#learnleagueedit', :format => false
  match 'learn/research' => 'static_pages#learnresearch', :format => false
  match 'learn/research/YHOO' => 'static_pages#learnryhoo', :format => false  
  match 'learn/end' => 'static_pages#learnend', :format => false  
  match 'settings' => 'static_pages#settings', :format => false
  match 'help' => 'static_pages#help', :format => false
  match 'process_async_orders' => 'orders#process_async_orders', :format => false


  resources :leagues do
    resources :portfolios, only: [:create, :show, :destroy] do
      resources :orders, only: [:create, :show, :new]
    end
  end

  root :to => "static_pages#home"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
