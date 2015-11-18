module Api
  module V1
    class ProductsController < ApplicationController

      def index
        @products = Product.with_translations(I18n.locale).published.includes(:category, :brand).order(:name)
      end

      def show
        @product = Product.where(id: params[:id]).with_translations(I18n.locale).published.includes(:category, :brand).first
      end

    end
  end
end
