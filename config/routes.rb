Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'personals', to: 'users/registrations#new_personal'
    post 'personals', to: 'users/registrations#create_personal'
    get 'sendaddresses', to: 'users/registrations#new_sendaddress'
    post 'sendaddresses', to: 'users/registrations#create_sendaddress'
  end

  root 'products#index'
  resources :users, only: :index
  resources :products do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  get 'mypage', to: 'users#mypage'
  get 'logout', to: 'users#logout'

  resources :cards,only: [:index, :new, :create, :destroy]

end