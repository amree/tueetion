Tueetion::Application.routes.draw do

  resources :invitations, only: [:index, :new, :create, :destroy]

  resources :staffs, only: [:index] do
    member do
      get :lock
    end
  end

  devise_for :users

  resources :bills do
    resources :bill_items, only: [:new, :create, :edit, :update, :destroy]
    resources :payments, only: [:new, :create, :destroy]
  end

  resources :centers, except: [:index] do
    resources :branches, except: [:index, :show]
  end

  resources :combination_fees do
    resources :combination_item_fees, except: [:index, :show]
  end
  resources :quantity_fees


  resources :students do
    resources :quantity_fee_enrolls, only: [:index, :create]
    resources :combination_fee_enrolls, only: [:index, :create]
    member do
      post :generate_bill
    end
  end
  resources :subjects

  get "dashboards/index"
  get "front_pages/index"

  namespace :admin do
    resources :users, only: [:index, :show]
  end

  namespace :settings do
    resources :accounts, only: [] do
      collection do
        get :edit
        get :edit_password
        patch :update
        patch :update_password
      end
    end
    resources :subscriptions, only: [:index]
  end

  root "front_pages#index"

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
