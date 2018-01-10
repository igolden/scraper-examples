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
      puts Nokogiri::HTML(browser.body)
      browse_pages(browser)
    else
      puts "Finished Scraping pages."
    end
  end
end
