module Api
  module V1
    class CartsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @order = Order.where(code: params['cart-token']).first
        @items = @order.try(:order_items)
      end

      def add
        @order = Order.where(code: params['cart-token']).first_or_create

        @item = @order.order_items.where(product_id: params['product-id']).first_or_initialize
        if @item.new_record?
          @item.quantity = params[:quantity]
        else
          @item.quantity = params[:quantity].to_i + @item.quantity
        end
        @success = @item.save
      end

      def remove
        @order = Order.where(code: params['cart-token']).first_or_create
        @item = @order.order_items.where(product_id: params['product-id']).first
        @success = @item.try(:destroy)
      end

    end
  end
end
