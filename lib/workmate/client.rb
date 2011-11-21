require 'json'
require 'oauth2'
module Workmate
  class Client
    BASE_URL = 'https://workmateapp.com'
    API_URL = "#{BASE_URL}/api"
    
    def initialize(client_id, client_secret, token = nil, url = BASE_URL)
      @client = OAuth2::Client.new(client_id, client_secret, :site => url)
      @token = OAuth2::AccessToken.from_hash(@client, access_token: token)
    end
    
    def call(uri)
      response = @token.get("#{API_URL}#{uri}.json", parse: :json)
      response.parsed
    end
    
    def me
      call('/users/me')
    end
    
    def user(user_id)
      call('/users/' + user_id)
    end
  end
end