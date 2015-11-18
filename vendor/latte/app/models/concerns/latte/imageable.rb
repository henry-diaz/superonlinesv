module Latte
  module Imageable
    extend ActiveSupport::Concern

    included do
      ##
      # Globalize settings
      translates :name, :description, fallbacks_for_empty_translations: true
      globalize_accessors
      globalize_validations locales: [LatteConfig[:languages].first]

      has_attached_file :image,
                        styles: {
                          medium: '300x300>',
                          thumb:  '100x100>'
                        },
                        default_url: ActionController::Base.helpers.asset_path('latte/missing.png')

      validates_attachment_content_type :image,
                                        content_type: /\Aimage\/.*\Z/

      belongs_to :imageable, polymorphic: true

      attr_accessor :delete_image
      before_validation { self.image = nil if delete_image == '1' }
    end

    def indentifier
      Digest::MD5.hexdigest(self.to_s)
    end
  end
end
