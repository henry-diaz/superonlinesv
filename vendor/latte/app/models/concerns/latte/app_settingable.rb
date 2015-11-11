module Latte
  module AppSettingable
    extend ActiveSupport::Concern

    included do

      def self.instance
        self.first || self.new
      end

      column_names.each do |column_name|
        unless method_defined? column_name
          define_singleton_method column_name do
            self.instance.send(column_name)
          end
        end
      end
    end
  end
end
