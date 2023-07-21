# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  get '/about', to: 'pages#about'
  get '/contribute', to: 'pages#contribute'
  get '/search', to: 'kpis#search'

  resources :categories, path: '/', only: [:show] do
    resources :kpis, path: '/', only: [:show]
  end

  root 'pages#home'
end
