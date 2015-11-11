module Latte
  class Latte::ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :authenticate_admin!

    def current_auth_resource
      current_admin
    end

    before_action :metatags
    def metatags
      set_meta_tags title: LatteConfig[:sitename], site: 'Latte CMS', reverse: true
    end

    before_action :set_locale
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(options = {})
      params[:locale].present? ? { locale: I18n.locale }.merge(options) : {}.merge(options)
    end
  end
end
