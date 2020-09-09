Rails.application.routes.draw do
  devise_for :users

  root 'telephone_books#index'

  namespace :api do
    namespace :v1 do
      resources :telephone_books do
        member do
          post :import
        end
      end
      resources :contacts
      resources :users
      get 'login' => 'users#login', as: :login
    end
  end

  resources :telephone_books do
    resources :contacts, shallow: true
    member do
      post :import
    end
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
