module Latte
  module Recipeable
    extend ActiveSupport::Concern

    included do
      ##
      # Globalize settings
      translates :name, :description, :ingredients, :preparation, :slug, fallbacks_for_empty_translations: true
      globalize_accessors
      globalize_validations locales: [LatteConfig[:languages].first]

      ##
      # Acts as taggable on settings
      acts_as_taggable

      ##
      # Paperclip image
      has_attached_file :image, styles: { medium: '410x410>', thumb: '205x205>' }, default_url: ActionController::Base.helpers.asset_path('latte/missing.png')
      validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
      attr_accessor :delete_image
      before_validation { self.image = nil if delete_image == '1' }

      ##
      # Associations
      belongs_to :recipes_category
      delegate :name, to: :recipes_category, prefix: true, allow_nil: true

      has_many :images, -> { with_translations(I18n.default_locale).order(priority: :asc, name: :asc, description: :asc) }, as: :imageable
      accepts_nested_attributes_for :images, allow_destroy: true

      has_many :videos, -> { with_translations(I18n.default_locale).order(priority: :asc, name: :asc, description: :asc) }, as: :videoable
      accepts_nested_attributes_for :videos, allow_destroy: true

      has_many :datafiles, -> { with_translations(I18n.default_locale).order(priority: :asc, name: :asc, description: :asc) }, as: :datafileable
      accepts_nested_attributes_for :datafiles, allow_destroy: true

      ##
      # Enum attributes
      enum status: [:disabled, :enabled]
    end

    def indentifier
      Digest::MD5.hexdigest(self.to_s)
    end
  end
end
