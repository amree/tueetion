require "resque_web"

Tueetion::Application.routes.draw do

  devise_for :users

  mount ResqueWeb::Engine => "/rq"
  ResqueWeb::Engine.eager_load!

  namespace :admin do
    resources :users, only: [:index, :show]
    resources :centers, only: [:index, :show]
    resources :countries
    resources :credits
    resources :subscriptions
  end

  resources :bills do
    resources :bill_items, only: [:new, :create, :edit, :update, :destroy]
    resources :payments, only: [:new, :create, :destroy]
    member do
      patch :activate
      patch :deactivate
    end
  end

  post '/callbacks/twilio', to: "callbacks#twilio"

  resources :centers, except: [:index] do
    collection do
      get :bulks
      get :create_bills
      get :deactivate_bills
    end
    resources :branches, except: [:index, :show]
  end

  resources :combination_fees do
    resources :combination_item_fees, except: [:index, :show]
  end

  get "dashboards/index"

  get 'fronts/index'

  resources :groups, except: [:show]

  resources :invitations, only: [:index, :new, :create, :destroy] do
    member do
      get :reinvite
    end
  end

  resources :messages, only: [:index, :new, :create, :destroy, :show] do
    get :update_status
  end

  resources :options, only: [:edit, :update]

  match 'pricing',        to: 'fronts#pricing',        via: [:get]
  match 'privacy-policy', to: 'fronts#privacy_policy', via: [:get]

  namespace :public do
    resources :students, only: [:show] do
      resources :bills, only: [:show]
    end
  end

  resources :quantity_fees

  namespace :reports do
    resources :payments, only: [:index]
    resources :registrations, only: [:index]
    resources :subjects, only: [:index]
    resources :packages, only: [:index]
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
    resources :credits, only: [:index, :show]
    resources :subscriptions, only: [:index, :show]
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
      post :create_bill
    end
  end

  resources :subjects

  root "fronts#index"
end
