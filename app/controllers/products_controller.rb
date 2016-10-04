class ProductsController < InheritedResources::Base

  def index
    count = 0#Product.q_count(params[:q])
    sql = Product.q(params[:q], params[:page], params[:per_page]).sort(params[:s]).to_sql

    # TBD pagination
    # TBD limit in query with min and max condition
    # TBD solr and posgres text search and lucene and %more comparisons
    # TBD API version
    # TBD api key or oauth2
    # TBD sorting
    # TBD keep one pre-search engine where a bot will search for frequent queries and their combination
    #     this is to keep frequest searches faster

    respond_to do |format|
      format.json { render json: { data: ActiveRecord::Base.connection.execute(sql), info: {
        resource: controller_name, count: count
      }}}
      
      format.any { render :index }
    end
  end
end

