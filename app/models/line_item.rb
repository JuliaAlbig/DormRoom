class LineItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
  attr_accessible :order_id, :price, :product_id, :quantity
end
