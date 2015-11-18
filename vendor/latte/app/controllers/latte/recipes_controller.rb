module Latte
  class RecipesController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Recipe
    end

    def order
      [:name]
    end

    def init_form
      @recipes_categories = RecipesCategory.with_translations(I18n.locale).order(:name)
    end

    def table_columns
      %w(name status recipes_category_id featured)
    end
  end
end
