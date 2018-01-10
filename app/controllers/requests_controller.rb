##
# RequestsController
#
# Simple controller to handle page requests
# for this application.
#
class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:events]
  def index; end

  def events
    @events = Event.all.limit(20)
  end

  def crawled_events
    @events = CrawledEvent.all
  end

  ## call the runner through controller action
  def scrape
    Event.scrape_with_microservice
    redirect_to events_path
  end

  def crawl
    CrawledEvent.scrape_with_capybara
    redirect_to crawled_events_path
  end
end
