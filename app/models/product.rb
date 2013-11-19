class Product < ActiveRecord::Base
	has_many :line_items
	has_many :orders, through: :line_items
	belongs_to :category
  attr_accessible :description, :name, :price, :stock_quantity, :image_file, :category_id
  validates :name, :price, :stock_quantity, :category_id, presence: true
  validate :name, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :stock_quantity, numericality: {greater_than_or_equal_to: 0}
end
