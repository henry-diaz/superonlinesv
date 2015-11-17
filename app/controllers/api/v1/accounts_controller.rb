module Api
  module V1
    class AccountsController < ApplicationController
      skip_before_action :verify_authenticity_token
      def signin
        @user = User.new
        @user.name = params['name']
        @user.username = params['username']
        @user.password = params['pass']
        @user.email = params['email']
        @user.address = params['address']
        @user.phone = params['phone']
        @user.credit_card = params['credit-card']
        @user.skip_confirmation!
        @success = @user.save
        @errors = @user.errors.full_messages unless @success
      end

      def login
        @user = User.where(username: params[:username]).first
        @success = @user.try(:valid_password?, params[:pass]) || false
        @code = @success ? @user.orders.draft.first.try(:code) : nil
      end

      def logout
        @user = User.where(username: params[:username]).first
        @success = @user.try(:valid_password?, params[:pass]) || false
        if @success
          order = @user.orders.where(code: params['cart-token']).first_or_create
          @code = order.code
        end
      end

    end
  end
end
