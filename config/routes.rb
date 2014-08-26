Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
    get "logout" => "devise/sessions#destroy"
  end
  resources :users

  root "pages#home"
  get 'faq', to: 'pages#faq'

  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "join", :to => "devise/registrations#new"
    get "logout", :to => "devise/sessions#destroy"
  end

end
