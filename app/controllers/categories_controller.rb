class CategoriesController < InheritedResources::Base

  def index
    @categoies = Category.q(params[:q])
    
    respond_to do |format|
      format.json { render json: @categoies.select_name_id }
    end
  end

  def root
    @categoies.root
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end

