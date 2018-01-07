class EventsScraper
  def intialize
    raise StandardError, "You can't instantiate this class"
  end

  # class methods
  class << self
    def download_events(pagenum=1)
      save_path = File.join(Rails.root, "lib/data")

      `cd #{save_path} && wget https://www.builtincolorado.com/events?page=#{pagenum} -O #{pagenum}`
    end
  end
end

EventsScraper.download_events
