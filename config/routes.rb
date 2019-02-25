Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      root "home#index"
      resources :home, only: %i(index)
    end
  end
end
