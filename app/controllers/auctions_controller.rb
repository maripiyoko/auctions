class AuctionsController < ApplicationController
  before_action :set_auction, only: [ :show ]

  def index
    # TODO : 開催中のオークションのみに限定すること
    @auctions = Auction.all.order(:deadline_date).page params[:page]
  end

  def show
  end

  private

    def set_auction
      # 誰でもどのオークション情報でも見れる
      @auction = Auction.find(params[:id])
    end
end
