Rails.application.routes.draw do
  # API defintion
  namespace :api, defaults:{format: :json} do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy]
      resources :tokens, only: %i[create]
      resources :products
      resources :orders
    end
  end
end
