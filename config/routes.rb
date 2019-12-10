Rails.application.routes.draw do
  root "statics#home"

  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations",
    passwords: "passwords"
  }

  resources :users do
    member do
      get "password"
      patch "update_password"
    end
  end

  resources :oauth_apps
  resources :authorizations
  resources :recharges
end
