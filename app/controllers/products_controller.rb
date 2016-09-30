class ProductsController < InheritedResources::Base

  def index
    @products = Product.q(params[:q]).sort(params[:s]).limit(100)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end

