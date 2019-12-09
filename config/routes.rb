Rails.application.routes.draw do
  root "statics#home"
  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations",
    passwords: "passwords"
  }
end
