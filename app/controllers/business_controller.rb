class BusinessController < ApplicationController
  def index
  	@products = Product.all
  end

  def search
  end

  def search_results
  	@products = Product.where("name LIKE ?", "%#{params[:keywords]}%")
  end
end
