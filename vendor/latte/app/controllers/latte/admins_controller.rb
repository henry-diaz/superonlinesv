module Latte
  class AdminsController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Admin
    end

    def order
      [:name, :email]
    end

    def table_columns
      %w(name email)
    end
  end
end
