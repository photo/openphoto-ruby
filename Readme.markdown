Open Photo API / Ruby Library
=======================
#### OpenPhoto, a photo service for the masses

----------------------------------------

<a name="install"></a>
### Installation
gem install openphoto-ruby

<a name="ruby"></a>
### How to use the library

To use the library you need to first require 'openphoto-ruby', retrieve your OAuth credentials, then instantiate an instance of the client and start making calls.

	require 'rubygems'
	require 'openphoto-ruby'

	@client = Openphoto::Client.new(@site, @consumer_key, @consumer_secret, @access_token, @access_token_secret)
	photo = @client.connect(:post, "/photo/upload.json", {"photo"=>"/tmp/photo.png", "permission"=>"1", "title"=>"test upload"})
	puts "#{photo.message} #{@site}/photo/#{photo.result["id"]}/view"

----------------------------------------

<a name="credentials"></a>
#### Getting your credentials

You can get your credentials by clicking on the arrow next to your email address once you're logged into your site and then clicking on settings.
If you don't have any credentials then you can create one for yourself by going to `/v1/oauth/flow`.
Once completed go back to the settings page and you should see the credential you just created