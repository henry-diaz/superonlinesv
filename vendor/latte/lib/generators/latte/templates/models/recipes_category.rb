class RecipesCategory < ActiveRecord::Base
  include Latte::RecipesCategorizable
  extend FriendlyId

  ##
  # Validations
  validates :status, presence: true
  validates :priority, presence: true
  validates :priority, numericality: { only_integer: true }
  # validates :image, presence: true
  # validates :recipes_category_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :recipes_category_id, case_sensitive: false }, allow_blank: true, allow_nil: true
  # validates :description, presence: true

  ##
  # This line will be below all validations
  validate :validates_globalized_attributes

  ##
  # Scopes
  scope :priority,  -> { order(:priority) }
  scope :published, -> { where(status: statuses[:enabled]) }

  ##
  # Willpaginate setup
  self.per_page = 10

  ##
  # FriendlyId setup
  friendly_id :name, use: [:slugged, :finders]
end
