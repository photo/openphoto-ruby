require 'openphoto-ruby'

describe Openphoto do
  before(:each) do
    options = YAML.load_file("spec/settings.yml")
    @consumer_key =  options["oauth"]["consumer_key"]
    @consumer_secret =  options["oauth"]["consumer_secret"]
    @access_token =  options["oauth"]["access_token"]
    @access_token_secret =  options["oauth"]["access_token_secret"]
    @site =  options["oauth"]["site"]
    @client = Openphoto::Client.new(@site, @consumer_key, @consumer_secret, @access_token, @access_token_secret)
  end
  
  it "says hello world" do
    out=@client.connect(:get, "/hello.json")
    out.message.should=="Hello, world!"
    out.code.should==200
  end

  it "says hello world with oauth" do
    out=@client.connect(:get, "/hello.json", {"auth"=>"true"})
    out.message.should=="Hello, world!"
    out.code.should==200

    @client = Openphoto::Client.new(@site, "bad credential", @consumer_secret, @access_token, @access_token_secret)
    out=@client.connect(:get, "/hello.json?auth=true")
    out.code.should==403
  end

  context "photos context" do

    it "uploads a photo" do
      
      out=@client.connect(:post, "/photo/upload.json", {"photo"=>"spec/logo.png", "permission"=>"1", "title"=>"rspec upload"})
      out.code.should==202
      out.message.should match("uploaded successfully")
      $upload_id = out.result["id"]
    end

    it "views a photo" do
      out=@client.connect(:get, "/photo/#{$upload_id}/view.json")
      out.result["title"].should match("rspec upload")
      out.code.should==200
    end
    
    it "adds an action" do
      out=@client.connect(:post, "/action/photo/#{$upload_id}/create.json", {"email"=>"test@openphoto.me", "type"=>"comment", "value"=>"hi there"})
      out.code.should==200
      out.code.should_not==403
      puts out.message
      puts out.result
      $comment_id = out.result["id"]
    end
    
    it "deletes an action" do
      out=@client.connect(:post, "/action/photo/#{$comment_id}/delete.json")
      out.code.should==200
      out.code.should_not==403
    end

    it "deletes a photo" do
      out=@client.connect(:post, "/photo/#{$upload_id}/delete.json")
      out.code.should==200
      out.code.should_not==403
      out.message.should match("Photo deleted successfully")
    end

  end
  
  
end