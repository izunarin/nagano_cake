Rails.application.routes.draw do
 
 root to: "public/homes#top"
 
 get "/about"=>"public/homes#about"
 
  namespace :admin do
   get '/' => "homes#top"
  end
  
 namespace :admin do
  resources :order_details, only: [:update] 
  resources :orders, only: [:orders, :update, :show] 
  resources :customers, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update] 
  resources :items, only: [:index, :new, :create, :show, :edit, :update] 
  end
  
  namespace :public do
    delete 'cart_items/destroy_all' => "cart_items#destroy_all"
  end
  
 namespace :public do
  resources :addresses, only: [:index, :edit, :create, :update, :destroy] 
  resources :cart_items, only: [:index, :update, :destroy, :create]
  resources :orders, only: [:new, :create, :index,]
  resource :customers,only:[:show, :edit, :update]
  resources :items, only: [:index, :show]
  end
  
  namespace :public do
    post 'orders/confirm' => "orders#confirm"
    get 'orders/withdraw' => "orders#thanks"
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
