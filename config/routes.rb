Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :posts do
    get 'for_user/:user_id', to: 'posts#for_user', on: :collection, as: 'for_user'
    
    resources :comments, except: :show
  end

  resources :comments, only: [] do
    resources :reactions, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
