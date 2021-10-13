Rails.application.routes.draw do
  # App Paths
  root to: "dashboard#index"

  # GraphQL
  post "/graphql", to: "graphql#execute"
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?

  # Devise Setup
  devise_scope :user do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  devise_for :users, path: "users"

  namespace :admin do
    get "dashboard", to: "dashboard#home"
    resources :organizations, only: [:show, :edit, :update]
    resources :admin_users, except: :destroy
    resources :volunteers, except: :destroy
    resources :students, except: :destroy
  end
end
