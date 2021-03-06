class Product < ActiveRecord::Base
  include Latte::Productable
  extend FriendlyId

  ##
  # Validations
  # validates :category_id, presence: true
  validates :status, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :category_id, case_sensitive: false }, allow_blank: true, allow_nil: true
  # validates :slogan, presence: true
  # validates :bundle_units, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  # validates :gross_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :net_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :spec, presence: true
  validates :description, presence: true
  # validates :image, presence: true
  # validates :tag_list, presence: true

  ##
  # This line will be below all validations
  validate :validates_globalized_attributes

  ##
  # Scopes
  scope :featured,       -> { where(featured: true) }
  scope :published,      -> { where(status: statuses[:enabled]) }
  scope :with_datafiles, -> { includes(:datafiles).where.not('datafiles.id' => nil) }
  scope :with_images,    -> { includes(:images).where.not('images.id' => nil) }
  scope :with_videos,    -> { includes(:videos).where.not('videos.id' => nil) }

  ##
  # Willpaginate setup
  self.per_page = 10

  ##
  # FriendlyId setup
  friendly_id :name, use: [:slugged, :finders]
end
