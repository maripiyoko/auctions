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
    respond_to do |format|
      if @bid.acceptable_price? && @bid.save
        flash[:notice] = '入札しました。'
        format.html { redirect_to @auction }
        format.js { render js: "window.location = '#{auction_path(@auction)}'" }
      else
        @bid.errors.each do |name, msg|
          flash.now[name] = msg
        end
        format.html { redirect_to @auction }
        format.js { render partial: "layouts/message", status: :unprocessable_entity }
      end
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
