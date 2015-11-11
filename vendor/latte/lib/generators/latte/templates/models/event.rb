class Event < ActiveRecord::Base
  include Latte::Eventable
  extend FriendlyId

  ##
  # Validations
  validates :status, presence: true
  # validates :category_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :category_id, case_sensitive: false }, allow_blank: true, allow_nil: true
  # validates :place, presence: true
  validates :start_at, date: true
  # validates :stop_at, date: { after: :start_at }
  # validates :price, presence: true, numericality: { greater_than: 0 }
  # validates :image, presence: true
  # validates :description, presence: true
  validates :content, presence: true
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
  scope :coming,         -> { where('start_at > ?', Time.zone.now).order(start_at: :asc) }
  scope :leaving,        -> { where('stop_at < ?', Time.zone.now).order(stop_at: :desc) }
  scope :current,        -> { where('start_at < ? AND stop_at > ?', Time.zone.now, Time.zone.now) }

  ##
  # Willpaginate setup
  self.per_page = 10

  ##
  # FriendlyId setup
  friendly_id :name, use: [:slugged, :finders]
end
