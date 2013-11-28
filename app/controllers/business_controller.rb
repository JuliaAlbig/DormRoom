class BusinessController < ApplicationController
  def index
  	@products = Product.all
  end

  def search
  end

  def search_results
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{params[:keywords]}%", "%#{params[:keywords]}%")
    @products = @products.where("category_id = ?", params[:category]) unless params[:category] == ""
  end

  def contact
  end

  def about
  end

  def saleproducts
    @products = Product.where("status_id = 2")
  end

  def newproducts
    @products = Product.where("status_id = 1")
  end

    def showall
      @categories = Category.order(:name).includes(:products)
  end
end