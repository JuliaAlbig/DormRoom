class Order < ActiveRecord::Base
	belongs_to :customer
	has_many :lineItems
  attr_accessible :customer_id, :gst_rate, :hst_rate, :pst_rate, :status
end
