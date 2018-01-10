require 'capybara'
require 'nokogiri'

##
# EventsCrawler 
#
# Uses capybara to visit the page and click
# through the pagination links until it 
# reaches the last page. 
#
# Avoided using a singleton class to show
# some different code.
# 
# @param entrypoint {string}
class EventsCrawler
  def initialize(entrypoint)
    ## Setup Capybara drivers and DO NOT
    ## use Chrome as the browser driver. 
    Capybara.register_driver :selenium do |app|  
      Capybara::Selenium::Driver.new(app, browser: :firefox)
    end

    ## Configure capybara actions
    Capybara.configure do |config|  
      config.default_max_wait_time = 10 # seconds
      config.default_driver = :selenium
    end

    ## instantiate the browser and driver
    @entrypoint = entrypoint
    @browser = Capybara.current_session
    @driver = @browser.driver.browser
  end

  def run
    ## visit scraping entrypoint
    @browser.visit(@entrypoint)

    ## loop and browse pages
    browse_pages(@browser)
  end

  private

  def browse_pages(browser)
    if browser.has_content?("Next ›")
      browser.click_link("Next ›")
      extract_events(browser.body)
      browse_pages(browser)
    else
      extract_events(browser.body)
      puts "Finished Scraping pages."
    end
  end

  def extract_events(page)
    html = Nokogiri::HTML(page)

    events = html.css('.view-id-events .view-content .views-row')

    ## loop over each event and extract data
    events.each do |e|
      ## target div because it will say "today"
      #  and it has a class of "date-not-today",
      #  or "date-today"
      event_data =  e.at_css('.left .date div').text

      ## date
      day = event_data.chars[0..2].join("")
      month = event_data.chars[3..5].join("")
      date = event_data.chars[6..event_data.length].join("").strip

      ## title
      title = e.at_css(".center .title a").text.strip

      ## organizer
      host = e.at_css(".center .organized-by").text.strip

      ## time
      time = e.at_css(".right .time").text

      ## categories, as an array
      categories = e.at_css(".right .category").text.split(", ")

      ## format the data into a Hash
      CrawledEvent.create(
        title: title,
        host: host,
        day: day,
        date: date,
        time: time,
        categories: categories
      )
    end
  end
end
