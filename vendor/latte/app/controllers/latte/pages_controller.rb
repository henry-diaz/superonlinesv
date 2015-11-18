module Latte
  class PagesController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Page
    end

    def order
      [:name, :priority]
    end

    def init_form
      @pages = Page.with_translations(I18n.locale).where.not(id: @item.try(:id)).order(:name)
    end

    def table_columns
      %w(name priority status in_navbar in_footer page_id)
    end
  end
end
