class AuctionsController < ApplicationController
  before_action :set_auction, only: [ :show ]

  def index
    if params.try("[]",:state) == 'closed'
      @auctions = Auction.close_items.page params[:page]
      render :index_closed
    else
      @auctions = Auction.open_items.page params[:page]
    end
  end

  private

    def set_auction
      # 誰でもどのオークション情報でも見れる
      @auction = Auction.find(params[:id])
    end
end
