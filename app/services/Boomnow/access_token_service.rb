require 'httparty'
module Boomnow
  class AccessTokenService
    BASE_URL = "https://app.boomnow.com/open_api/v1".freeze

    def initialize
      @client_id = ENV['BOOMNOW_CLIENT_ID']
      @client_secret = ENV['BOOMNOW_CLIENT_SECRET']
    end

    # Fetch the authentication token from BoomNow API
    def get_token
      url = "#{BASE_URL}/auth/token"
      
      response = HTTParty.post(url, body: {
        client_id: @client_id,
        client_secret: @client_secret
      }.to_json, headers: {
        "Content-Type" => 'application/json',
        "Accept" => 'application/json'
      })

      # Parse and return the access token from the response
      parsed_response = response.parsed_response
      parsed_response["access_token"]
    end
  end
end
