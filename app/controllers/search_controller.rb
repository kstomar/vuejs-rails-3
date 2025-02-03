class SearchController < ApplicationController
  def index
  end

  def listings
    token_service = Boomnow::AccessTokenService.new()
    token = token_service.get_token

    # Use the BoomnowListingsService to fetch listings
    listings_service = Boomnow::ListingsService.new(params[:city], params[:adults], token)
    listings = listings_service.get_listings

    # Extract listings data from the API response
    listings_data = listings["listings"] # Assuming 'listings' is the key in the API response

    render json: listings_data
  end
end
