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

  resources :oauth_apps do
    get "secret_keys", on: :member
  end
  resources :authorizations, only: %i(index new create destroy)

  scope :oauth do
    get "authorize", to: "authorizations#authorize"
    post "token", to: "authorizations#token"
  end

  resources :recharges do
    collection do
      get "pending"
      get "done"
    end
  end
end
