require 'openphoto-ruby'

describe Openphoto do
  before(:each) do
    options = YAML.load_file("spec/settings.yml")
    @consumer_key =  options["oauth"]["consumer_key"]
    @consumer_secret =  options["oauth"]["consumer_secret"]
    @access_token =  options["oauth"]["access_token"]
    @access_token_secret =  options["oauth"]["access_token_secret"]
    @site =  options["oauth"]["site"]
  end

  it "views a photo" do
    @client = Openphoto::Client.new(@site, @consumer_key, @consumer_secret, @access_token, @access_token_secret)
    out=@client.connect(:get, "/photo/1/view.json")
    out.result["hash"].should match("6e3db0cc6e14342652b3f43d9b5c5ea50e76c4e9")
    out.code.should==200
  end
  
  it "deletes a photo" do
    @client = Openphoto::Client.new(@site, @consumer_key, @consumer_secret, @access_token, @access_token_secret)
    out=@client.connect(:post, "/action/1/delete.json")
    out.code.should==200
    out.code.should_not==403
  end

  
end