module Latte
  module EventPriceable
    extend ActiveSupport::Concern

    included do
      ##
      # Globalize settings
      translates :name, fallbacks_for_empty_translations: true
      globalize_accessors
      globalize_validations locales: [LatteConfig[:languages].first]
    end

    def indentifier
      Digest::MD5.hexdigest(self.to_s)
    end
  end
end
