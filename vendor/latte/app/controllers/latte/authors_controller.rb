module Latte
  class AuthorsController < Latte::ApplicationController
    include Latte::Tabled

    def model
      Author
    end

    def order
      [:name]
    end

    def init_form
      @admins = Admin.order(:name)
    end

    def table_columns
      %w(name admin_id)
    end
  end
end
