class AuctionsController < ApplicationController
  before_action :set_auction, only: [ :show ]

  def index
    ### 少し条件がややこしいので、if params.try("[]",:state) == 'closed' でも良さそう
    # if !params[:state].nil? && params[:state] == 'closed'
    if params.try("[]",:state) == 'closed'
      @auctions = Auction.close_items.page params[:page]
      render :index_closed
    else
      @auctions = Auction.open_items.page params[:page]
    end
  end

  def show
    # オークション詳細情報ページでは、入札できるので、
    # 締め切りを過ぎているオークションがあれば、締める。
    ### closedカラムが無ければ要らない
    # Auction.close_all_over_deadline_auctions!
  end

  private

    def set_auction
      # 誰でもどのオークション情報でも見れる
      @auction = Auction.find(params[:id])
    end
end
