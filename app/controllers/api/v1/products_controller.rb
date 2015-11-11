module Api
  module V1
    class ProductsController < ApplicationController

      def index
        @products = Product.with_translations(I18n.locale).published.includes(:category, :brand).order(:name)
      end

    end
  end
end
