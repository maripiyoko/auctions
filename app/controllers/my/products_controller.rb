class My::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products.order(:updated_at).page params[:page]
  end

end
