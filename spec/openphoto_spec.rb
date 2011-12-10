require 'openphoto-ruby'

describe Openphoto do
  it "broccoli is gross" do
    Openphoto.portray("Broccoli").should eql("Gross!")
  end

  it "anything else is delicious" do
    Openphoto.portray("Not Broccoli").should eql("Delicious!")
  end
end