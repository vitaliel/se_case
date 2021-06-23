Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :connections, only: :index do
    collection do
      post :add
    end
  end

  resources :accounts, only: :index
  resources :transactions, only: :index

  root to: 'connections#index'

  post '/callbacks/success', to: 'callbacks#success'
end
