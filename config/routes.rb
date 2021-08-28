Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'home#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/user', to: 'user#info'
  resources :advertisements, only: [:index, :show, :create, :update, :destroy]
  resources :comments, only: [:create, :update, :destroy]
  get '/advertisements/:id/comments', to: 'advertisements#comments_on_ad'
end
