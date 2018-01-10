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
    @events = Event.all
  end

  def additional_events
    @events = Event.all.limit(20)
  end

  ## call the runner through controller action
  def scrape
    Event.scrape_all
    redirect_to events_path
  end

  def crawl
    Event.scrape_with_capybara
    redirect_to events_path
  end
end
