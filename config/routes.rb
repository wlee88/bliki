Blox::Application.routes.draw do

  resources :pages
  resources :posts do
    resources :comments
  end
  match "/posts/store" => "posts#store", :as => "store_posts"
  match "/posts/save_desc" => "posts#set_post_description", :as => "save_description_post"
  match "/posts/save_title" => "posts#set_post_title", :as => "save_description_title"
  match "/posts/save_tags" => "posts#set_post_tags", :as => "save_post_tags"
  match "/posts/save_box_desc" => "posts#set_box_desc", :as => "save_boxes_desc"
  match "/posts/say_hi" => "posts#say_hi", :as => "say_hi"

  match "boxes/set_box_tags" => "boxes#set_box_tags", :as => "save_boxes_tag"
  match "boxes/set_box_desc" => "boxes#set_box_desc"
  match "boxes/update_sort_box" => "boxes#update_sort_box", :as => "update_sort_box"
  match "searches/update_search_box" => "searches#update_sort_box"
  match "posts/update_sort_box" => "posts#update_sort_box"
  match "posts/update_sort_post" => "posts#update_sort_post"
  match "posts/update_sort_post_date" => "posts#update_sort_post_date"
  match "boxes/copy_box" => "boxes#copy_box", :as => "copy_box"
  match "posts/create_favorite" => "posts#create_favorite", :as => "create_favorite"
  match "posts/delete_favorite" => "posts#delete_favorite", :as => "delete_favorite"
  get "sessions/new"
  
  get "users/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "searches#index"
  
  get "boxes/me" => "boxes#me", :as => "my_boxes"
  
  resources :users
  resources :sessions
  resources :searches
  
  resources :boxes do
    resources :comments
  end

  get "home/index"
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
