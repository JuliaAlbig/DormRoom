class BusinessController < ApplicationController
  before_filter :initialize_cart

  def index
    @products = Product.where("status_id = 1").limit(4)
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

    def show
    @product = Product.find(params[:id])
  end

  def showall
      @categories = Category.order(:name).includes(:products)
  end

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to action: :cart
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to action: :cart
  end

  def cart
  end

  def empty_cart
    session[:cart] = []
    redirect_to action: :showall
  end

  def checkout
  end

protected
  def initialize_cart
    session[:cart] ||=[]
    @cart_contents ||= []
    session[:cart].each { |id| @cart_contents << Product.find(id) }
  end
end