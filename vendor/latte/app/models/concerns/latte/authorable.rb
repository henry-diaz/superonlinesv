module Latte
  module Authorable
    extend ActiveSupport::Concern

    included do
      ##
      # Globalize settings
      translates :about, :slug, fallbacks_for_empty_translations: true
      globalize_accessors
      globalize_validations locales: [LatteConfig[:languages].first]

      ##
      # Paperclip image
      has_attached_file :image, styles: { medium: '410x410>', thumb: '205x205>' }, default_url: ActionController::Base.helpers.asset_path('latte/missing.png')
      validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
      attr_accessor :delete_image
      before_validation { self.image = nil if delete_image == '1' }

      ##
      # Associations
      has_many :articles
      belongs_to :admin
    end

    def indentifier
      Digest::MD5.hexdigest(self.to_s)
    end
  end
end
