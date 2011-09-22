module CloudLogger

  class Papertrail < Base

    def initialize(options)
      @user = options[:user]
      @pass = options[:pass]
    end

    def log(message)
      raise "sending logs is not supported for the Papertrail driver"
    end

    def search(query)
      raw_response = RestClient.get("https://#{@user}:#{@pass}@papertrailapp.com/api/vi/events/search.json", {:params => {:q => query}})
      result = JSON.parse(raw_response)['events'].map do |log_entry|
        CloudLogger::Event.new(log_entry['message'], log_entry['received_at'])
      end 
      yield result if block_given?
      result
    end
  end
end
