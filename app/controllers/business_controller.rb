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
    @page = Page.find(2)
  end

  def about
    @page = Page.find(1)
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

  def order
    if params[:province] = ""
      province = ""
    else
      province = Province.where("name = '" + params[:province] + "'").first.id
      @gst = params[:province].gst_rate
      @pst = params[:province].pst_rate
      @hst = params[:province].hst_rate
    end

    @customer = Customer.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      address: params[:address],
      city: params[:city],
      province_id: province,
      country: "Canada", 
      postal_code: params[:postal_code]
    )

    if @customer.save
      customer_id = @customer.id
      @order = Order.create(
        gst_rate: @gst, 
        hst_rate: @hst, 
        pst_rate: @pst, 
        status: "unshipped",
        customer_id: customer_id
      )
      order_id = @order.id

      @cart_contents.each do |product|
        LineItem.create(
          order_id: order_id, 
          price: product.price,
          product_id: product.id,
          quantity: 1
        )
      end 

      @subtotal = @cart_contents.sum("price")
      @total = @subtotal * (1 + @order.gst_rate + @order.pst_rate + @order.hst_rate)

      @cart_contents = []
      session[:cart] = []
    end
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
    @total = 0.00
    session[:cart].each { |id| @cart_contents << Product.find(id) }
    @cart_contents.each do |product|
      @total += product.price
    end
  end
end