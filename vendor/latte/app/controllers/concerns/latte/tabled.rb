module Latte
  module Tabled
    extend ActiveSupport::Concern

    included do
      respond_to :html, :json

      before_filter :init_breadcrumb

      helper_method :edit_item_url
      helper_method :index_url
      helper_method :item_url
      helper_method :model
      helper_method :namespace
      helper_method :new_item_url
      helper_method :table_headers
    end

    def item_params
      params.require(model.name.underscore).permit(permits)
    end

    def permits
      LatteConfig[:schema][model.name.underscore.pluralize.to_sym].map{ |field|
        if field.pluralize == field && field.singularize != field && LatteConfig[:schema].keys.include?(field)
          { "#{field}_attributes".to_sym => (LatteConfig[:schema][field.to_sym] + [:id, :_destroy]).map(&:to_sym) }
        else
          field.to_sym
        end
      }.flatten
    end

    def init_breadcrumb
      add_breadcrumb I18n.t('layouts.latte.application.breadcrumb.home'), latte_root_url
    end

    def conditions(conditions = {})
      conditions
    end

    def namespace
      :latte
    end

    def model
      nil
    end

    def index_url
      url_for action: :index
    end

    def item_url(id)
      url_for action: :show, id: id
    end

    def edit_item_url(id)
      url_for action: :edit, id: id
    end

    def new_item_url
      url_for action: :new
    end

    def init_form
    end

    def table_columns
      []
    end

    def translatable_column?(column)
      model.translated_attribute_names.include?(column.to_sym) &&
        LatteConfig[:schema][model.name.underscore.pluralize.to_sym].include?("#{column}_#{I18n.default_locale}")
    end

    def table_headers
      table_columns.select{ |column| LatteConfig[:schema][model.name.underscore.pluralize.to_sym].include?(column) || translatable_column?(column) }
    end

    def order
      {}
    end

    def parse_column_name?(column_name)
      model.translated_attribute_names.include?(column_name.to_sym) && !column_name.to_s.include?(model.translations_table_name)
    end

    def parsed_order
      return order unless model.translates? && order.is_a?(Array)
      order.map{ |column| parse_column_name?(column) ? "#{model.translations_table_name}.#{column}" : column }
    end

    def index
      scope  = model.translates? ? model.with_translations(I18n.default_locale) : model
      @items = scope.where(conditions).order(parsed_order).paginate(page: params[:page], per_page: 10)

      add_breadcrumb model.model_name.human(count: :many), index_url

      respond_to do |format|
        format.html { render template: 'concerns/latte/tabled/index' }
        format.json { render json: @items }
      end
    end

    def show
      @item = model.find params[:id]

      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.latte.application.breadcrumb.show')

      respond_to do |format|
        format.html
        format.json { render json: @item }
      end
    end

    def new
      @item = model.new

      init_form

      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.latte.application.breadcrumb.new'), new_item_url

      respond_to do |format|
        format.html { render template: 'concerns/latte/tabled/new' }
        format.json { render json: @item }
      end
    end

    def create
      @item = model.new item_params

      if @item.save
        redirect_to url_for(action: :edit, id: @item.id), notice: t('layouts.latte.application.notice.created')
      else
        init_form
        add_breadcrumb model.model_name.human(count: :many), index_url
        add_breadcrumb t('layouts.latte.application.breadcrumb.new')

        render template: 'concerns/latte/tabled/new'
      end
    end

    def edit
      @item = model.find params[:id]
      init_form
      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.latte.application.breadcrumb.edit')

      render template: 'concerns/latte/tabled/edit'
    end

    def update
      @item = model.find params[:id]
      if @item.update_attributes item_params
        redirect_to url_for(action: :edit, id: @item.id), notice: t('layouts.latte.application.notice.updated')
      else
        init_form
        add_breadcrumb model.model_name.human(count: :many), index_url
        add_breadcrumb t('layouts.latte.application.breadcrumb.edit')
        render template: 'concerns/latte/tabled/edit'
      end
    end

    def destroy
      model.find(params[:id]).destroy
      redirect_to url_for(action: :index), notice: t('layouts.latte.application.notice.deleted')
    end
  end
end
