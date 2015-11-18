class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :code, presence: true, uniqueness: true

  scope :draft, -> { where(status: 'draft') }
end
