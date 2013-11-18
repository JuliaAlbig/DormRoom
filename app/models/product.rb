class Product < ActiveRecord::Base
	has_many :line_items
	has_many :orders, through :line_items
	belongs_to :category
  attr_accessible :description, :name, :price, :stock_quantity, :image_file, :category_id
end
