class Event < ActiveRecord::Base
  validates_uniqueness_of :title
  class << self
    def scrape_all
      EventsScraper.run
    end

    def self.scrape_with_capybara
    end
  end
end
