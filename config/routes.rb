# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  get '/about', to: 'pages#about'
  get '/contribute', to: 'pages#contribute'
  get '/search', to: 'kpis#search'
  get '/sign_in', to: 'pages#sign_in'
  get '/sitemap', to: 'pages#sitemap', defaults: { format: 'xml' }

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  namespace :admin do
    resources :notifications, only: [:index]
    resources :users, only: [:index, :show]
    root to: 'dashboard#index'
  end

  resources :categories, path: '/', only: [:show] do
    resources :subcategories, path: '/s', only: [:show]
    resources :kpis, path: '/', only: [:show] do
      member do
        get    :votes
        post   :upvote
        delete :downvote
      end
    end
  end

  resources :comments, only: [:create, :update, :destroy]

  resources :notifications, only: [:create]

  root 'pages#home'
end
