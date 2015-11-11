module Latte
  module Datafileable
    extend ActiveSupport::Concern

    included do
      ##
      # Globalize settings
      translates :name, :description, fallbacks_for_empty_translations: true
      globalize_accessors
      globalize_validations locales: [LatteConfig[:languages].first]

      ##
      # Paperclip datafile
      has_attached_file :datafile
      do_not_validate_attachment_file_type :datafile # TODO, get a full list of secure content types
      attr_accessor :delete_datafile
      before_validation { self.datafile = nil if delete_datafile == '1' }

      ##
      # Paperclip image
      has_attached_file :image, styles: { medium: '300x300>', thumb:  '100x100>' }, default_url: ActionController::Base.helpers.asset_path('latte/missing.png')
      validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
      attr_accessor :delete_image
      before_validation { self.image = nil if delete_image == '1' }

      ##
      # Associations
      belongs_to :datafileable, polymorphic: true
    end

    def indentifier
      Digest::MD5.hexdigest(self.to_s)
    end
  end
end
