Demo::Application.routes.draw do
  devise_for :admins
  get "users/index"
  get "user/rake"
  get "user/routes"
  get "welcome/index"
  get "posts/new"
  root "welcome#index"
  get '/search_user', to: 'welcome#search_user'
  match '/users',   to: 'users#index',   via: 'get'
  match '/follow_or_unfollow',to: 'welcome#follow_or_unfollow',via:[:get,:post]
  match '/re_tweet',to: 'welcome#re_tweet',via:[:get,:post]
  match '/messages',to: 'welcome#messages',via:[:get,:post]
  match '/home',to: 'welcome#index',via:[:get,:post]
  get '/getrealtime_msgs', to: 'welcome#getrealtime_msgs'
  match '/create_msg', to: 'welcome#create_msg',via:[:get,:post]
  
  
 
    resources :posts  do
      resources :comments
    end
  

  devise_for :users
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
