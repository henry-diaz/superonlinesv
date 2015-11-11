module Latte
  class CategoriesController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Category
    end

    def order
      [:name, :priority]
    end

    def init_form
      @categories = Category.with_translations(I18n.locale).where.not(id: @item.try(:id)).order(:name)
    end

    def table_columns
      %w(name priority status category_id)
    end
  end
end
