require 'date'

module CloudLogger

  class Event

    attr_accessor :timestamp, :text

    def initialize(text, timestamp)
      @text = text
      @timestamp = DateTime.parse(timestamp)
    end
  end
end
