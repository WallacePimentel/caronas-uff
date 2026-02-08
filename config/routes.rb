Rails.application.routes.draw do
  resources :carpools
  resources :campus
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'
end
