module Latte
  class RecipesCategoriesController < Latte::ApplicationController
    include Latte::Tabled

    def model
      RecipesCategory
    end

    def order
      [:name, :priority]
    end

    def init_form
      @recipes_categories = RecipesCategory.with_translations(I18n.locale).where.not(id: @item.try(:id)).order(:name)
    end

    def table_columns
      %w(name priority status recipes_category_id)
    end
  end
end
