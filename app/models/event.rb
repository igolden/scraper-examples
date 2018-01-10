class Event < ActiveRecord::Base
  validates_uniqueness_of :title
  class << self
    ## uses lib/events_scraper.rb
    def scrape_with_microservice
      EventsScraper.run
    end
  end
end
