# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  resources :categories, path: '/', only: [:show] do
    resources :kpis, path: '/', only: [:show]
  end

  root 'pages#home'
end
