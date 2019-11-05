Rails.application.routes.draw do
  root 'articles#index'

  resource :session, only: %i(new create destroy)
  resources :articles
  resources :users, only: %i() do
    resources :articles, only: %i(index)
  end
  resources :tags, only: %i() do
    resources :articles, only: %i(index)
  end
end
