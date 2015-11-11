class Image < ActiveRecord::Base
  include Latte::Imageable

  ##
  # Validations
  validates :priority, presence: true
  validates :priority, numericality: { only_integer: true }
  validates :image, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :imageable, case_sensitive: false }, allow_blank: true, allow_nil: true
  # validates :description, presence: true

  ##
  # This line will be below all validations
  validate :validates_globalized_attributes
end
