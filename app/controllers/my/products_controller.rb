class My::ProductsController < My::ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    respond_to do |format|
      format.html do
        @products = current_user.products.order(:updated_at).page params[:page]
      end
      format.json { render json: current_user.products }
    end
  end

  def new
    @product = current_user.products.new
  end

  def show
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @product }
    end
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to my_products_path, notice: "商品を登録しました。"
    else
      redirect_to my_products_path, alert: "商品を登録出来ませんでした。"
    end
  end

  def update
    if @product.update(product_params)
      redirect_to my_products_path, notice: "商品を更新しました。"
    else
      redirect_to my_products_path, alert: "商品を更新出来ませんでした。"
    end
  end

  def destroy
    if @product.auctions.empty?
      @product.destroy
      redirect_to my_products_path, notice: "商品を削除しました。"
    else
      redirect_to my_products_path, alert: "商品にはオークション情報があります。削除出来ません。"
    end
  end

  private

    def set_product
      @product = current_user.products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description)
    end

end
