class Page < ActiveRecord::Base
  include Latte::Pageable
  extend FriendlyId

  ##
  # Validations
  validates :status, presence: true
  validates :priority, presence: true
  validates :priority, numericality: { only_integer: true }
  # validates :page_id, presence: true
  # validates :image, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :page_id, case_sensitive: false }, allow_blank: true, allow_nil: true
  # validates :description, presence: true
  validates :content, presence: true
  # validates :tag_list, presence: true

  ##
  # This line will be below all validations
  validate :validates_globalized_attributes

  ##
  # Scopes
  scope :in_footer,      -> { where(in_footer: true) }
  scope :in_navbar,      -> { where(in_navbar: true) }
  scope :priority,       -> { order(:priority) }
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
