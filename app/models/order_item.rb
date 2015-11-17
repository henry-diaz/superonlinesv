class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  delegate :id, :name, :featured, :image_url, :sku, :category_name, :brand_name, :price, to: :product, allow_nil: true, prefix: true
end
