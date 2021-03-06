class LineItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
  attr_accessible :order_id, :price, :product_id, :quantity

  validates :order_id, :price, :product_id, :quantity, presence: true
  validates :price, :quantity, numericality: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :quantity, numericality: {greater_than_or_equal_to: 1}
end
