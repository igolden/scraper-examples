class EventScraper
  def intialize
    raise StandardError, "You can't instantiate this class"
  end

  # class methods
  class << self
    def download_events
      `wget https://www.builtincolorado.com/events`
    end
  end
end
