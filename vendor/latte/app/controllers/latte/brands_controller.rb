module Latte
  class BrandsController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Brand
    end

    def order
      [:name]
    end

    def table_columns
      %w(name)
    end
  end
end
