SlbShare::Application.routes.draw do
  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :posts do
    collection do      
      match 'search' => 'posts#search', via: [:get, :post], as: :search
      get 'favorites'
    end
    member do
      post 'favorite'
      post 'unfavorite'
    end
  end
  get 'posts/by_year_and_month/:year/:month' => 'posts#by_year_and_month', :as=> :posts_by_year_and_month
  get 'user/:user_id/posts', to: 'posts#user', as: :user_posts
  get '/new_index', to: 'posts#new_index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  match "/" => 'posts#index', via: [:get, :post], as: :root


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
