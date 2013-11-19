class BusinessController < ApplicationController
  def index
  	@products = Product.all
  end

end
