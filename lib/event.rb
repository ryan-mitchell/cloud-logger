require 'date'

module CloudLogger

  class Event

    attr_accessor :timestamp, :text

    def initialize(text, timestamp)
      @text = text
      
      if timestamp.instance_of? DateTime
        @timestamp = timestamp
      elsif timestamp.instance_of? Fixnum
        @timestamp = DateTime.new(timestamp)
      else
        @timestamp = DateTime.parse(timestamp.to_s)
      end
    end
  end
end
