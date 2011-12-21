require 'rubygems'
require 'openphoto-ruby'

#load our credentials
options = YAML.load_file("spec/settings.yml")
@consumer_key =  options["oauth"]["consumer_key"]
@consumer_secret =  options["oauth"]["consumer_secret"]
@access_token =  options["oauth"]["access_token"]
@access_token_secret =  options["oauth"]["access_token_secret"]
@site =  options["oauth"]["site"]

#create a client
@client = Openphoto::Client.new(@site, @consumer_key, @consumer_secret, @access_token, @access_token_secret)

#connect to GetHelloWorld
#http://theopenphotoproject.org/documentation/api/GetHelloWorld
puts @client.connect(:get, "/hello.json").message

#upload a photo
#http://theopenphotoproject.org/documentation/api/PostPhotoUpload
puts "uploading spec/logo.png..."
photo = @client.connect(:post, "/photo/upload.json", {"photo"=>"spec/logo.png", "permission"=>"1", "title"=>"test upload"})
puts "#{photo.message} #{@site}/photo/#{photo.result["id"]}/view"

