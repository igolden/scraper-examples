class CrawledEvent < ActiveRecord::Base
  validates_uniqueness_of :title
  class << self
    ## uses lib/events_crawler.rb
    def scrape_with_capybara
      crawler = EventsCrawler.new('https://builtincolorado.com/events')
      crawler.run
    end
  end
end
