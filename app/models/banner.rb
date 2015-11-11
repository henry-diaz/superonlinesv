class Banner < ActiveRecord::Base
  include Latte::Bannerable

  ##
  # Validations
  validates :status, presence: true
  validates :priority, presence: true
  validates :priority, numericality: { only_integer: true }
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }, allow_blank: true, allow_nil: true
  validates :image, presence: true
  validates :url, url: { allow_blank: true }

  ##
  # Scopes
  scope :featured,  -> { where(featured: true) }
  scope :priority,  -> { order(:priority) }
  scope :published, -> { where(status: statuses[:enabled]) }

  ##
  # Willpaginate setup
  self.per_page = 10
end
