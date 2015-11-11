module Latte
  class ArticlesController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Article
    end

    def order
      { name: :asc, published_at: :desc }
    end

    def init_form
      @categories = Category.with_translations(I18n.locale).order(:name)
      @authors    = Author.order(:name)
    end

    def table_columns
      %w(name status category_id featured published_at author_name)
    end
  end
end
