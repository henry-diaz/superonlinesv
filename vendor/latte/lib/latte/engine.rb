require 'acts-as-taggable-on'
require 'bootstrap-sass'
require 'breadcrumbs_on_rails'
require 'ckeditor'
require 'date_validator'
require 'devise'
require 'draper'
require 'friendly_id'
require 'haml-rails'
require 'meta-tags'
require 'nested_form'
require 'paperclip'
require 'will_paginate-bootstrap'
require 'will_paginate'
require 'bootstrap_form'
require 'ransack'
require 'validate_url'
require 'font-awesome-sass'
require 'globalize'
require 'globalize-accessors'
require 'globalize-validations'
require 'omniauth'
require 'omniauth-twitter'
require 'omniauth-facebook'
require 'omniauth-instagram'

module Latte
  class Engine < ::Rails::Engine

    config.autoload_paths += %W(
      #{config.root}/app/controllers/concerns/latte
      #{config.root}/app/models/concerns/latte
    )

    config.assets.paths += %W(
      #{config.root}/app/assets/images/latte
      #{config.root}/app/assets/stylesheets/latte
      #{config.root}/app/assets/javascripts/latte
    )
  end
end

if File.exists? 'config/latte.yml'
  LatteConfig = YAML.load_file('config/latte.yml').with_indifferent_access
end
