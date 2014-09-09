class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @search_query = params[:city]
    @listings = Listing.search(params)
  end
end
