Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "logins#new"
    delete "/logout", to: "logins#destroy"
    namespace :admin do
      root "home#index"
      resources :users, only: %i(index new create destroy) do
        get "(page/:page)", action: :index, on: :collection
      end
    end
    namespace :trainer do
      root "home#index"
      resources :users, only: %i(index new create destroy) do
        get "(page/:page)", action: :index, on: :collection
      end
    end
    resources :users, only: %i(show)
    resources :logins, only: %i(create)
  end
end
