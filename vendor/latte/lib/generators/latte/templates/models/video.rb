class Video < ActiveRecord::Base
  include Latte::Videoable

  ##
  # Validations
  validates :priority, presence: true
  validates :priority, numericality: { only_integer: true }
  validates :video, presence: true, if: proc{ |o| o.url.blank?   }
  validates :url,   presence: true, if: proc{ |o| o.video.blank? }
  #validates :image, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :videoable, case_sensitive: false }, allow_blank: true, allow_nil: true
  # validates :description, presence: true

  ##
  # This line will be below all validations
  validate :validates_globalized_attributes
end
