module Latte
  class BannersController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Banner
    end

    def order
      [:name, :priority, :url]
    end

    def table_columns
      %w(name priority status featured url)
    end
  end
end
