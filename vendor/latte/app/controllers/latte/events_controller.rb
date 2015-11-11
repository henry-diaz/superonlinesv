module Latte
  class EventsController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Event
    end

    def order
      [:name, :start_at, :place]
    end

    def init_form
      @categories = Category.with_translations(I18n.locale).order(:name)
    end

    def table_columns
      %w(name status featured category_id start_at place)
    end
  end
end
