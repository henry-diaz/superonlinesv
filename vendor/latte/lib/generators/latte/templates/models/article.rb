class Article < ActiveRecord::Base
  include Latte::Articleable
  extend FriendlyId

  ##
  # Validations
  validates :status, presence: true
  validates :published_at, date: true
  # validates :image, presence: true
  # validates :category_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :category_id, case_sensitive: false }, allow_blank: true, allow_nil: true
  # validates :description, presence: true
  validates :content, presence: true
  # validates :tag_list, presence: true
  # validates :author_id, presence: true

  ##
  # This line will be below all validations
  validate :validates_globalized_attributes

  ##
  # Scopes
  scope :featured,       -> { where(featured: true) }
  scope :newer,          -> { order(published_at: :desc) }
  scope :older,          -> { order(published_at: :asc) }
  scope :published,      -> { where(status: statuses[:enabled]).where('published_at < ?', Time.zone.now) }
  scope :with_datafiles, -> { includes(:datafiles).where.not('datafiles.id' => nil) }
  scope :with_images,    -> { includes(:images).where.not('images.id' => nil) }
  scope :with_videos,    -> { includes(:videos).where.not('videos.id' => nil) }
  scope :x_days_ago,     -> (days) { where('published_at BETWEEN ? AND ?', Date.current.advance(days: (days * -1)).beginning_of_day, Date.current.advance(days: (days * -1)).end_of_day) }

  ##
  # Willpaginate setup
  self.per_page = 10

  ##
  # FriendlyId setup
  friendly_id :name, use: [:slugged, :finders]
end
