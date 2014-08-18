class ListingsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def new
    @listing = Listing.new
  end
end
