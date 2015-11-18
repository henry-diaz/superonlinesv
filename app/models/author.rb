class Author < ActiveRecord::Base
  include Latte::Authorable
  extend FriendlyId

  ##
  # Validations
  # validates :admin_id, presence: true
  validates :name, presence: true
  # validates :website_url, presence: true
  validates :website_url, url: { allow_blank: true }
  # validates :twitter_url, presence: true
  validates :twitter_url, url: { allow_blank: true }
  # validates :facebook_url, presence: true
  validates :facebook_url, url: { allow_blank: true }
  # validates :linkedin_url, presence: true
  validates :linkedin_url, url: { allow_blank: true }
  # validates :gplus_url, presence: true
  validates :gplus_url, url: { allow_blank: true }
  # validates :youtube_url, presence: true
  validates :youtube_url, url: { allow_blank: true }
  # validates :about, presence: true
  # validates :image, presence: true

  ##
  # This line will be below all validations
  validate :validates_globalized_attributes

  ##
  # FriendlyId setup
  friendly_id :name, use: [:slugged, :finders]
end
