##
# This is a simple smoketest for scraping with
# capybara outside of the Rspec context.
#
# - should visit url and keep running
# - should be able to find/click links
# - should be able to interact with js 
#   generated content
#
require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'


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
browser = Capybara.current_session
driver = browser.driver.browser

## visit scraping entrypoint
browser.visit("https://builtincolorado.com/events")

## simple browse method to 
def browse_pages(browser)
  while browser.has_content?("Next ›")
    browser.click_link("Next ›")
    puts "Currently scraping: #{browser.current_url}"
    browse(browser)
  end
  puts "Finished Scraping pages."
end

## loop and browse pages
browse_pages(browser)







