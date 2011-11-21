require 'json'
require 'oauth2'
module Workmate
  class Client
    BASE_URL = 'http://workmateapp.com'
    
    def initialize(client_id, client_secret, token = nil, url = BASE_URL)
      @base_url = url
      @client = OAuth2::Client.new(client_id, client_secret, :site => url)
      @token = OAuth2::AccessToken.from_hash(@client, access_token: token)
    end
    
    def call(uri)
      response = @token.get("#{api_url}#{uri}.json", parse: :json)
      response.parsed
    end
    
    def me
      call('/users/me')
    end
    
    def user(user_id)
      call('/users/' + user_id)
    end
    
    protected
    def api_url
      "#{@base_url}/api"
    end
  end
end