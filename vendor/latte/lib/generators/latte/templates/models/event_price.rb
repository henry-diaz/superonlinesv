class EventPrice < ActiveRecord::Base
  include Latte::EventPriceable

  ##
  # Validations
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  ##
  # This line will be below all validations
  validate :validates_globalized_attributes
end
