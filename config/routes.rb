Tueetion::Application.routes.draw do

  namespace :admin do
    resources :users, only: [:index, :show]
  end

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

  resources :groups, except: [:show]

  resources :invitations, only: [:index, :new, :create, :destroy] do
    member do
      get :reinvite
    end
  end

  resources :quantity_fees

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

  resources :staffs, only: [:index] do
    member do
      patch :lock
      patch :unlock
    end
  end

  resources :students do
    resources :quantity_fee_enrolls, only: [:index, :create]
    resources :combination_fee_enrolls, only: [:index, :create]
    resources :combination_fee_enroll_subjects, only: [:edit, :update]
    member do
      post :generate_bill
    end
  end
  resources :subjects

  devise_for :users

  get "dashboards/index"
  get "front_pages/index"

  root "front_pages#index"
end
