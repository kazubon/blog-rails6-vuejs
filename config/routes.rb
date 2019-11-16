Rails.application.routes.draw do
  root 'entries#index'

  resource :session, only: %i(new create destroy)
  resources :entries do
    resource :star, only: %i(update)
  end
  resources :users, only: %i() do
    resources :entries, only: %i(index)
  end
end
