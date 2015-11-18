module Latte
  class AppSettingsController < Latte::ApplicationController
    include Latte::Tabled

    def model
      AppSetting
    end

    def init_form
      @item  = AppSetting.instance
      @pages = Page.with_translations(I18n.locale).order(:name)
    end

    def table_columns
      %w(description)
    end
  end
end
