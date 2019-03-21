Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
    get "activate/:id", to: "activate_accounts#edit", as: :activate
    put "activate/:id", to: "activate_accounts#update"
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
      resources :reports, only: %i(index show destroy) do
        get "(page/:page)", action: :index, on: :collection
      end
    end
    namespace :trainee do
      root "home#index"
      resources :reports
      resources :bulk_reports, only: %i(destroy)
      resources :filter_reports, only: %i(index)
    end
    resources :logins, only: %i(create)
    resources :users do
      resources :profiles, only: %i(new create)
    end
    resources :profiles, only: %i(edit update)
    resources :passwords, only: %i(update)
    resources :password_resets, only: %i(new create edit update)
  end
end
