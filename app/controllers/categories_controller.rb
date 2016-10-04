class CategoriesController < InheritedResources::Base

  def index
    sql = Category.q(params[:q]).to_sql

    respond_to do |format|
      format.json { render json: { data: ActiveRecord::Base.connection.execute(sql), info: {
        resource: controller_name
      }}}
      
    end
  end

  def root
    @categoies.root
  end
end

