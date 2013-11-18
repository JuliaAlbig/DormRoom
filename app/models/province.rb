class Province < ActiveRecord::Base
	has_many :customers
  attr_accessible :gst, :hst, :name, :pst
  validates :name, :gst, :hst, :pst, presence: true
  validates :name, uniqueness: true
end
