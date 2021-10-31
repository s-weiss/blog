Rails.application.routes.draw do
  resources :posts do
    get 'for_user/:user_id', to: 'posts#for_user', on: :collection, as: 'for_user'

    resources :comments, except: :show
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
