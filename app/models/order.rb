class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :code, presence: true, uniqueness: true

  scope :draft, -> { where(status: 'draft') }

  def amount
    items = order_items
    items.collect{|i| i.quantity.to_i.to_f * i.product_price}.sum
  end
end
