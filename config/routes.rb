Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  mount Ckeditor::Engine => "/ckeditor"
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
    namespace :trainee do
      root "home#index"
      resources :reports, only: %i(new create show edit update)
    end
    resources :logins, only: %i(create)
  end
end
