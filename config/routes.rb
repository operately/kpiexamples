# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  get '/about', to: 'pages#about'
  get '/contribute', to: 'pages#contribute'
  get '/search', to: 'kpis#search'
  get '/users/sign_in', to: 'pages#sign_in'
  get '/sitemap', to: 'pages#sitemap', defaults: { format: 'xml' }

  resources :categories, path: '/', only: [:show] do
    resources :subcategories, path: '/s', only: [:show]
    resources :kpis, path: '/', only: [:show]
  end

  resources :notifications, only: [:create]

  root 'pages#home'
end
