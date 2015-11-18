module Latte
  module Bannerable
    extend ActiveSupport::Concern

    included do
      ##
      # Paperclip image
      has_attached_file :image, styles: { medium: '410x410>', thumb: '205x205>' }, default_url: ActionController::Base.helpers.asset_path('latte/missing.png')
      validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
      attr_accessor :delete_image
      before_validation { self.image = nil if delete_image == '1' }

      ##
      # Enum attributes
      enum status: [:disabled, :enabled]
    end
  end
end
