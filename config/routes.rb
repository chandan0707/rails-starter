Rails.application.routes.draw do


  get 'settings/account'

  get 'settings/password'

  get 'settings/notifications'

  get 'settings/profile'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :users

  root "pages#home"
  get 'faq', to: 'pages#faq'

  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "join", :to => "devise/registrations#new"
    get "logout", :to => "devise/sessions#destroy"
  end


end
