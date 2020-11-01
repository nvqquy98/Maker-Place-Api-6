Rails.application.routes.draw do
  # API defintion
  namespace :api, defaults:{format: :json} do
    namespace :v1 do

    end
  end
end
