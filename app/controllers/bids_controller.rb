class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auction

  def new
    @modal_title = "#{@auction.name} に入札します"
    @bid = current_user.bids.new(auction: @auction)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @bid = current_user.bids.new(bid_params)
    @bid.auction = @auction
    if @bid.acceptable_price?
      if @bid.save
        redirect_to @auction, notice: '入札しました。'
      else
        redirect_to @auction, alert: '入札出来ませんでした。'
      end
    else
      redirect_to @auction, alert: '入札金額が低すぎます。'
    end
  end

  def destroy
    @bid = current_user.bids.find_by!(auction: @auction)
    @bid.destroy
    redirect_to @auction, notice: '入札を取り消しました。'
  end

  private

    def set_auction
      @auction = Auction.find(params[:auction_id])
    end
  
    def bid_params
      params.require(:bid).permit(:price)
    end
end
