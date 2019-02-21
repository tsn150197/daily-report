Rails.application.routes.draw do
  root "logins#new"
  get "/password_reset", to: "password_resets#new"
  get "/activate_account", to: "activate_accounts#new"
end
