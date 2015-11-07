class My::CommentsController < My::ApplicationController
  before_action :set_bid
  before_action :set_comment, only: [ :show, :edit, :update, :destroy ]

  private

    def set_bid
      @bid = current_user.bids.find(params[:bid_id])
    end

    def set_comment
      @comment = @bid.comment
    end

    def comment_params
      params.require(:comment).permit(:evaluation, :comment)
    end
end
