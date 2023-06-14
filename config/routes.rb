# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get "/kpis/:id", to: "kpis#show", as: "kpi"
  root 'pages#home'
end
