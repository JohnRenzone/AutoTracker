# Route prefixes use a single letter to allow for vanity urls of two or more characters
Rails.application.routes.draw do
  if defined? Sidekiq
    require 'sidekiq/web'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web, at: '/admin/sidekiq/jobs', as: :sidekiq
    end
  end

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin' if defined? RailsAdmin

  # Static pages
  match '/error' => 'pages#error', via: [:get, :post], as: 'error_page'
  get '/terms' => 'pages#terms', as: 'terms'
  get '/privacy' => 'pages#privacy', as: 'privacy'

  # OAuth
  oauth_prefix = Rails.application.config.auth.omniauth.path_prefix
  get "#{oauth_prefix}/:provider/callback" => 'users/oauth#create'
  get "#{oauth_prefix}/failure" => 'users/oauth#failure'
  get "#{oauth_prefix}/:provider" => 'users/oauth#passthru', as: 'provider_auth'
  get oauth_prefix => redirect("#{oauth_prefix}/login")

  # Devise
  devise_prefix = Rails.application.config.auth.devise.path_prefix

  # hack for blocking registration
  get "#{devise_prefix}/signup" => redirect('404')

  devise_for :users, path: devise_prefix,
             controllers: {registrations: 'users/registrations',
                           sessions: 'users/sessions',
                           passwords: 'users/passwords',
                           confirmations: 'users/confirmations',
                           unlocks: 'users/unlocks',
                           :invitations => 'users/invitations'},
             path_names: {sign_up: 'signup', sign_in: 'login', sign_out: 'logout'}

  devise_scope :user do
    get "#{devise_prefix}/after" => 'users/registrations#after_auth', as: 'user_root'
    root 'users/sessions#new'
  end

  get devise_prefix => redirect('/a/signup')

  # User
  resources :users, path: 'u', only: [:show, :index, :new, :edit, :update, :create, :destroy] do
    collection do
      get :login_as
      get :new_technician
      get :technicians
      get :service_advisors

      post :create_technician
    end

    member do
      post :login

      delete :destroy
    end

    resources :authentications, path: 'accounts'
  end

  resources :dealerships, except: :show
  resources :inventories, only: [:create]

  get '/home' => 'users#show', as: 'user_home'

  # Dummy preview pages for testing.
  get '/p/test' => 'pages#test', as: 'test'
  get '/p/email' => 'pages#email' if ENV['ALLOW_EMAIL_PREVIEW'].present?

  get 'robots.:format' => 'robots#index'

  resources :vehicle_report_cards, path: 'reports' do
    resources :next_maintenance_appointments
    resources :scheduled_maintenance_items
    resources :fluid_levels
    resources :wiper_blades
    resources :vehicle_components
    resources :tire_wear_indicates
    resources :brake_wear_indicates
    member do
      get :send_pdf
      get :email_pdf
    end
  end
end
