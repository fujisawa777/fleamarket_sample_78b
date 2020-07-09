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
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
