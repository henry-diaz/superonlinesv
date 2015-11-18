module Latte
  module RecipesCategorizable
    extend ActiveSupport::Concern

    included do
      ##
      # Globalize settings
      translates :name, :description, :slug, fallbacks_for_empty_translations: true
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

      has_many :recipes_categories
      has_many :recipes

      ##
      # Enum attributes
      enum status: [:disabled, :enabled]
    end

    def level
      lvl = 1
      cat = self
      while !cat.recipes_category.nil?
        cat = cat.recipes_category
        lvl += 1
      end
      lvl
    end

    def offspring_ids
      recipes_categories.map{ |cat| [cat.id] + cat.offspring_ids }.flatten
    end

    def parents
      arr = []
      cat = self
      while !cat.recipes_category.nil?
        cat = cat.recipes_category
        arr << cat
      end
      arr
    end

    def indentifier
      Digest::MD5.hexdigest(self.to_s)
    end
  end
end
