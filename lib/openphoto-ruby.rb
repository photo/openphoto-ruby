require "openphoto-ruby/version"

module Openphoto

  class Client
    require 'oauth'
    require 'json'
    require 'pp'
    attr_accessor :hostname, :consumer_key, :consumer_secret, :access_token, :access_token_secret
    
    def initialize(hostname, consumer_key, consumer_secret, access_token, access_token_secret)
      @hostname = hostname
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret
      @access_token = access_token
      @access_token_secret = access_token_secret
    end
    
    def connect(method,path)
      access_token = prepare_access_token
      response = access_token.request(method.to_sym, path)
      response.extend Openphoto::Response
      return response
    end

    # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
    def prepare_access_token
      consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret,
        { :site => @hostname,
          :scheme => :header,
          :access_token_path=>"/v1/oauth/token/access",
          :authorize_path => "/v1/oauth/authorize",
          :request_token_path => "/v1/oauth/token/request"
        })

      access_token = OAuth::AccessToken.from_hash(consumer, :oauth_token => @access_token, :oauth_token_secret => @access_token_secret) 
      return access_token
    end

  end
  
  module Response
    #adds OpenPhoto related functions to Net::HTTPResponse

    def json
      JSON.parse(response.body)
    end
    
    def result
      json["result"]
    end

    def message
      json["message"]
    end
    
    def code
      json["code"]
    end

  end
  
  # contrived rspec examples
  def self.portray(food)
    if food.downcase == "broccoli"
      "Gross!"
    else
      "Delicious!"
    end
  end
end

