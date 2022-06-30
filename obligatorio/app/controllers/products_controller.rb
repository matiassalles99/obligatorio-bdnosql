class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(create_params)

    if @product.valid?
      @product.save!
      redirect_to products_path, status: :see_other
    else
      @error = @product.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:product).permit(Product.fillable)
  end
end
