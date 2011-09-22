require 'spec_helper'

describe CloudLogger::Event do

  it "should construct a valid event from a DateTime instance" do
    time = DateTime.now
    event = CloudLogger::Event.new('test', time)
    event.timestamp.should be_instance_of DateTime
  end

  it "should construct a valid event from a Time instance" do
    time = Time.now
    event = CloudLogger::Event.new('test', time)
    event.timestamp.should be_instance_of DateTime
  end

  it "should construct a valid event from a Date instance" do
    time = Date.today
    event = CloudLogger::Event.new('test', time)
    event.timestamp.should be_instance_of DateTime
  end

  it "should construct a valid event from a string representation of a date" do
    time = "2011-09-21T18:48:55.151Z"
    event = CloudLogger::Event.new('test', time)
    event.timestamp.should be_instance_of DateTime
  end

  it "should construct a valid event from a Unix timestamp" do
    time = 1316645975
    event = CloudLogger::Event.new('test', time)
    event.timestamp.should be_instance_of DateTime
  end
end
