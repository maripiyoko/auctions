class My::BidsController < My::ApplicationController

  def index
    @bids = Bid.successful.user(current_user)
  end

end
