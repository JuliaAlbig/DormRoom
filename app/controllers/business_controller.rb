class BusinessController < ApplicationController
  def index
  	@products = Product.all
  end

  def search
  end

  def search_results
    @products = Product.where("name OR description LIKE ?", "%#{params[:keywords]}%")
    @products = @products.where("category_id LIKE ?", "%#{params[:category]}") unless params[:category] = ""
  end

  def contact
  end

  def about
  end
end