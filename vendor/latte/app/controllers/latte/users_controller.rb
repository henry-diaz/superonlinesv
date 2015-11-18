module Latte
  class UsersController < Latte::ApplicationController
    include Latte::Tabled

    def model
      User
    end

    def order
      [:name, :email]
    end

    def table_columns
      %w(name email)
    end
  end
end
