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

      def checkout
        @user = User.where(username: params[:username]).first
        @success = @user.try(:valid_password?, params[:pass]) || false
        @total = 0
        if @success
          @order = Order.where(code: params['cart-token']).first
          if @order
            @items = @order.try(:order_items)
            @order.user_id = @user.id
            @order.status = 'sold'
            @order.save
            @total = @order.amount
            @message = "Checkout completado con éxito"
          else
            @success = false
            @message = "No se encontro el carrito de compras #{params['cart-token']}"
          end
        else
          @message = "Usuario o contraseña incorrectos"
        end

      end

    end
  end
end
