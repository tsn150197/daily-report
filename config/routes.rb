Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      root "home#index"
      resources :users, only: %i(new create)
    end
    namespace :trainer do
      root "home#index"
      resources :users, only: %i(new create)
    end
  end
end
