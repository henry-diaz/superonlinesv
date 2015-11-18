module Latte
  class ProductsController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Product
    end

    def order
      [:name]
    end

    def init_form
      @categories = Category.with_translations(I18n.locale).order(:name)
      @brands = Brand.order(:name)
    end

    def table_columns
      %w(name status featured price category_id)
    end
  end
end
