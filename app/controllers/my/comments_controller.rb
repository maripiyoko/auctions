class My::CommentsController < My::ApplicationController
  before_action :set_bid
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def new
    @comment = current_user.comments.new(bid: @bid)
  end

  def edit
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.bid = @bid
    if @comment.save
      redirect_to my_bids_path, notice: 'コメントを書きました。'
    else
      render :new, alert: "コメントが保存できませんでした。"
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to my_bids_path, notice: 'コメントを修正しました。'
    else
      redirect_to my_bids_path, alert: 'コメントを修正出来ませんでした。'
    end
  end

  def destroy
    @comment.destroy
    redirect_to my_bids_path, notice: 'コメントを削除しました。'
  end

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
