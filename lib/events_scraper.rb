require 'nokogiri'

class EventsScraper
  def intialize
    raise StandardError, "You can't instantiate this class"
  end

  # class methods
  class << self
    ##
    # Uses UNIX tools to download the page. Easy,
    # dependable, and available on linux servers
    #
    def download_events(pagenum=1)
      save_path = File.join(Rails.root, "lib/data")

      `cd #{save_path} && wget https://www.builtincolorado.com/events?page=#{pagenum} -O #{pagenum}`
    end

    ##
    # loads the files from lib/data/*
    #
    def prepare_files
      path = File.join(Rails.root, "lib/data")
      all_files = Dir.entries(path) 

      ## exclude the wget-log from the dir
      ## also ignores the first two entries
      ## which are '.' and '..'
      files = all_files[2..all_files.length].delete_if { |f| f.include?('wget-log') }

      return files
    end

    ##
    # Parses each files events
    #
    def parse_events(files)
      path = File.join(Rails.root, "lib/data")
      files.each do |f|
        data = File.open(File.join(path, f))
        html = Nokogiri::HTML(data)

        ## empty array
        saved_events = Array.new()

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
          formatted_event = {
            title: title,
            host: host,
            day: day,
            date: date,
            time: time,
            categories: categories
          }

          ## add to saved events
          saved_events << formatted_event
        end

        return saved_events
      end
    end

    ##
    # Saves the events to the database
    #
    def save_events
      puts "TODO"
    end

    ##
    # Runs the need commands in order
    #
    def run
      ## self.download_events
      files = prepare_files
      events = parse_events(files)
      save_events
    end
  end
end

EventsScraper.run
