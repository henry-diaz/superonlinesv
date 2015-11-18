module Latte
  module Videoable
    extend ActiveSupport::Concern

    included do
      ##
      # Globalize settings
      translates :name, :description, fallbacks_for_empty_translations: true
      globalize_accessors
      globalize_validations locales: [LatteConfig[:languages].first]

      ##
      # Paperclip video
      has_attached_file :video
      validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
      attr_accessor :delete_video
      before_validation { self.video = nil if delete_video == '1' }

      ##
      # Paperclip image
      has_attached_file :image, styles: { medium: '300x300>', thumb:  '100x100>' }, default_url: ActionController::Base.helpers.asset_path('latte/missing.png')
      validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
      attr_accessor :delete_image
      before_validation { self.image = nil if delete_image == '1' }

      ##
      # Associations
      belongs_to :videoable, polymorphic: true
    end

    def indentifier
      Digest::MD5.hexdigest(self.to_s)
    end
  end
end
