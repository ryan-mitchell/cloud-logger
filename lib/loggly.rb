module CloudLogger
  
  class Loggly < Base

    # a json object with a data property which is an array with zero or more elements
    #ResponseMatcher = /\{\s*"data": \[\s*(\{.*?\})*\s*\]/m

    def initialize(options)
      @subdomain = options[:subdomain]
      @user = options[:user]
      @pass = options[:pass]
      @key = options[:key]
      @ec2 = options[:ec2] ||= false
    end

    def log(log_data)
      ec2flag = @ec2 ? 'ec2.' : ''
      RestClient.post("https://#{ec2flag}logs.loggly.com/inputs/#{@key}", log_data)
    end

    def search(query)
      raw_response = RestClient.get("https://#{@user}:#{@pass}@#{@subdomain}.loggly.com/api/search", {:params => {:q => query}})
      result = JSON.parse(raw_response)['data'].map do |log_entry|
        CloudLogger::Event.new(log_entry['text'], log_entry['timestamp'])
      end 
      yield result if block_given?
      result
    end
  end
end
