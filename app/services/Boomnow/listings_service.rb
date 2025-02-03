require 'httparty'
module Boomnow
  class ListingsService
    BASE_URL = "https://app.boomnow.com/open_api/v1".freeze

    def initialize(city, adults, token)
      @city = city
      @adults = adults
      @token = token
    end

    # Fetch listings using the BoomNow API
    def get_listings
      url = "#{BASE_URL}/listings"
      response = HTTParty.get(url, headers: {
        "Authorization" => "Bearer #{@token}",
        "Accept" => 'application/json'
      }, query: {
        city: @city,
        adults: @adults
      })

      # Parse and return the listings from the response
      response.parsed_response
    end
  end
end