module Latte
  class OrdersController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Order
    end

    def order
      [:created_at]
    end

    def init_form
    end

    def table_columns
      %w(created_at status code user_id amount)
    end

    def index
      scope  = model.translates? ? model.with_translations(I18n.default_locale) : model
      @items = scope.where(conditions).order(parsed_order).paginate(page: params[:page], per_page: 10)

      add_breadcrumb model.model_name.human(count: :many), index_url

      respond_to do |format|
        format.html
        format.json { render json: @items }
      end
    end
  end
end
