Rails.application.routes.draw do
 
 namespace :admin do
  resources :order_details, only: [:update] 
  resources :orders, only: [:orders, :update, :show] 
  resources :customers, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update] 
  resources :items, only: [:index, :new, :create, :show, :edit, :update] 
  resources :homes, only: [:top] 
  end
 
 namespace :public do
  resources :addresses, only: [:index, :edit, :create, :update, :destroy] 
  resources :cart_items, only: [:index, :update, :destroy, :create]
  resources :orders, only: [:new, :create, :index, :show]
  resource :customers,only:[:show, :edit, :update]
  resources :items, only: [:index, :show]
  resources :homes, only: [:top, :about]
  end
  
  namespace :public do
    get 'orders/unsubscribe' => "orders#confirm"
    get 'orders/withdraw' => "orders#thanks"
  end
 
 namespace :public do
    get 'cart_items/destroy_all' => "cart_items#destroy_all"
  end
 
  namespace :public do
    get 'customers/unsubscribe' => "customers#unsubscribe"
    get 'customers/withdraw' => "customers#withdraw"
  end

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

end
