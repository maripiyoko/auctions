class AuctionsController < ApplicationController
  def index
    @auctions = Auction.all.order(:deadline_date).page params[:page]
  end

  def show
  end
end
