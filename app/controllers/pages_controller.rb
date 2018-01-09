##
# PagesController
#
# Simple controller to handle page requests
# for this application.
#
class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:events]
  def index; end

  def events
    @events = Event.all.limit(20)
  end

  ## call the runner through controller action
  def scrape
    Event.scrape_all
    redirect_to events_path
  end
end
