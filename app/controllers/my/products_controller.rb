class My::ProductsController < My::ApplicationController

  def index
    @products = current_user.products.order(:updated_at).page params[:page]
  end

end
