Rails.application.routes.draw do
  root to: 'posts#index'
  get "/drafted", to: "posts#drafted", as: "drafted"
  resources :posts do
    resources :comments
  end
  resources :tags
end
