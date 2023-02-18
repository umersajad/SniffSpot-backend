Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :spots, only: [:index, :show, :create, :update], shallow: true do
        resources :reviews, only: [:index, :create, :update]
      end
      post '/login', to: "authentication#login"
    end
  end
end