Rails.application.routes.draw do
  root 'top#index'

  resource :session, only: %i(new create destroy)
  resource :articles
end
