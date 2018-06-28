Rails.application.routes.draw do

  get 'forum', to: 'forum#index'
  get 'forum/reply/:id', to: 'forum#reply'
  get 'forum/post'
  post 'forum/create'
  post "forum/review_create"
  get 'forum/show/:id', to: 'forum#show'



  get '/catalog/main'
  get 'catalog/index'
  get '/catalog', to: 'catalog#index'
  get 'catalog/latest'
  get 'catalog/search', to: 'catalog#search'
  get '/catalog/rss', to: 'catalog#rss', format: 'rss'
  get '/catalog/:id', to: 'catalog#show', as: 'catalog_item'
  post '/catalog/:id', to: 'catalog#show'

  #resources :cart
  post 'cart/add/:id', to: 'cart#add', as: 'add_item'
  post 'cart/remove/:id', to: 'cart#remove', as: 'remove_item'
  post 'cart/clear', to: 'cart#clear'
  get 'cart', to: 'cart#view_cart'
  # Routes for namespace admin/publisher
  namespace :admin do
    resources :publishers
  end
  namespace :admin do
    resources :books
  end
  resources :tags, only: [:index, :show]

  #post 'admin/books/create', to: 'admin_book#reate'


  namespace :admin do
    get 'author/new'
  end

  namespace :admin do
    post 'author/create'
  end

  namespace :admin do
    get 'author/edit'
  end

  namespace :admin do
    post 'author/update'
  end

  namespace :admin do
    post 'author/destroy'
  end

  namespace :admin do
    get 'author/show'
  end

  namespace :admin do
    get 'author/index'
  end

  get 'about/index'

  root 'catalog#main'

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
