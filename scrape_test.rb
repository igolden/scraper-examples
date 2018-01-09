##
# Simple scrape smoketest for microservice

require 'nokogiri'

## open the downloaded html
file = File.open("lib/events.html")

## instantiate nokogiri object
f = Nokogiri::HTML(file)

## extract css
pages = f.at_css('nav.pager')
events = f.css('.view-id-events .view-content .views-row')

## method for getting page rage
# - This will be used to determine the 
#   number of pages to download
def extract_page_range
  # do in lib/scrape_events
end

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
end
