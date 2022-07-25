Rails.application.routes.draw do
  devise_for :users
  root to: "public#index"

  authenticate :user do
    resources :posts, only: %i[create]
    get '/like', to: 'posts#like', as: :like
  end
end
