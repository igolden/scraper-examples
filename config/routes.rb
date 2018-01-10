Rails.application.routes.draw do
  devise_for :users

  get '/events', controller: 'requests', action: 'events', as: 'events'
  get '/crawled_events', controller: 'requests', action: 'crawled_events', as: 'crawled_events'

  post '/scrape', controller: 'requests', action: 'scrape', as: 'scrape_events'
  post '/crawl', controller: 'requests', action: 'crawl', as: 'crawl_events'

  root "requests#index"
end
