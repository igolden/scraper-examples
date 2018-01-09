Rails.application.routes.draw do
  devise_for :users

  get '/events', controller: 'pages', action: 'events', as: 'events'
  post '/scrape', controller: 'pages', action: 'scrape', as: 'scrape_events'

  root "pages#index"
end
