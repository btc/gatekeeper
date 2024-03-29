Vern::Application.routes.draw do

  get 'statistics/index'

  post "notifications/post_full_name"

  get "roles/manage"
  post "roles/update"

  get 'photos/webcam'
  post 'photos/upload'
  post 'photos/webcam_create'
  get 'photos/link'       # presently* used to retrieve url for photo given id

  scope 'api' do
    resources :reservations
    resources :tables do
      get 'date', on: :collection
    end
    resources :photos
    resources :guests do
      get 'full_name_search', on: :collection
      get 'birthdays', on: :collection
      get 'duplicates', on: :collection
    end
    resources :committees
    resources :events
    resources :invitations do
      get :autocomplete_tag_name, on: :collection
    end
    resources :guest_lists do
      get 'search', on: :collection
      post 'append'
      get 'form', on: :collection
      get 'master', on: :collection
    end
    resources :notes
  end

  devise_for :users,
  controllers: {
    registrations: 'my_devise/registrations'
  }

  root :to => 'root#index'

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
