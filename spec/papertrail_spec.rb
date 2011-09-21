require 'spec_helper'

describe CloudLogger::Papertrail do

  before(:all) do
    @test_user = 'user'
    @test_pass = 'pass'
    @logger = CloudLogger::Papertrail.new(
      :user => @test_user, 
      :pass => @test_pass, 
    )
  end

  describe "#search" do

    before(:each) do
      RestClient.stub!(:get)
      Kernel.stub!(:print)
      @test_response = JSON.generate({ :events => [ { :received_at => "2011-09-21T18:48:55.15-07:00", :message => "Test Data" } ] })

    end

    it "should generate an appropriate RestClient GET" do

      search_string = "search string"
      RestClient.should_receive(:get).with(
        "https://#{@test_user}:#{@test_pass}@papertrailapp.com/api/vi/events/search.json", 
        {:params => {:q => search_string}}
      ).and_return(@test_response)
      @logger.search(search_string)
    end

    it "should convert the returned text to a CloudLogger::Event" do
      RestClient.should_receive(:get).and_return(@test_response)
      @logger.search("Test Data") do |data|
        data.first.should be_instance_of CloudLogger::Event
        data.first.text.should == "Test Data"
      end
    end

    it "should execute the callback if one is provided" do

      Kernel.should_receive(:print).with an_instance_of Array 
      RestClient.should_receive(:get).and_return(@test_response)

      @logger.search('anything') do |data|
        Kernel.print data
        data.first.should be_instance_of CloudLogger::Event
      end
    end

    it "should return the response if no callback is provided" do

      RestClient.should_receive(:get).and_return(@test_response)
      @logger.search('anything').should_not be_nil
    end
  end
end
