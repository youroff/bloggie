Rails.application.routes.draw do

  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end
  root 'welcome#index'
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  resources :users
  resources :posts
  resource  :session
  resource  :profile, only: :show

  # get 'users/:id/blog', to: 'users#blog', as: 'blog'
  # get 'users/:id/feed', to: 'users#feed', as: 'feed'
  # get 'users/:id/follow', to: 'users#follow', as: 'follow'
  # get 'users/:id/unfollow', to: 'users#unfollow', as: 'unfollow'
  #
  #
  #
  #
  # get 'posts/new', as: 'new_post'
  #
  # post 'posts/create', as: 'posts'
  #
  # get 'posts/:id/edit', to: 'posts#edit', as: 'edit_post'
  # patch 'posts/:id/update', to: 'posts#update', as: 'post'
  # get 'posts/:id/show', to: 'posts#show'
  # delete 'posts/:id/destroy', to: 'posts#destroy', as: 'delete_post'
  #
  # get 'signup', to: 'users#new', as: 'signup'
  # get 'login', to: 'sessions#new', as: 'login'
  # get 'logout', to: 'sessions#destroy', as: 'logout'
  # post 'createsession', to: 'sessions#create', as: 'createsession'
   
  namespace :api, defaults: {format: :json} do
    resources :users
    resources :posts
    get 'users/:id/blog', to: 'users#blog', as: 'blog'
    get 'users/:id/feed', to: 'users#feed', as: 'feed'
    get 'who_am_i', to: 'users#who_am_i', as: 'who_am_i'

  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'users#index'

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
