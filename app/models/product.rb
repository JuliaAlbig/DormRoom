class Product < ActiveRecord::Base
	has_many :lineItems
  attr_accessible :description, :name, :price, :stock_quantity
end
