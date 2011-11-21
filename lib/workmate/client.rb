require 'json'
require 'oauth2'
module Workmate
  class Client
    BASE_URL = 'http://localhost.localdomain:3000'
    API_URL = "#{BASE_URL}/api"
    
    def initialize(client_id, client_secret, token = nil)
      @client = OAuth2::Client.new(client_id, client_secret, :site => BASE_URL)
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