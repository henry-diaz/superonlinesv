# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'latte/version'

Gem::Specification.new do |spec|
  spec.name          = "latte"
  spec.version       = Latte::VERSION
  spec.authors       = ["el_quick"]
  spec.email         = ["el.quick@gmail.com"]
  spec.summary       = "CMS DE CAFEINA DIGITAL STUDIO"
  spec.description   = "CMS DE CAFEINA DIGITAL STUDIO"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  ##
  # Gem dependencies
  spec.add_dependency 'acts-as-taggable-on', '~> 3.5.0'
  spec.add_dependency 'bootstrap-sass', '~> 3.3.4.1'
  spec.add_dependency 'breadcrumbs_on_rails', '~> 2.3.0'
  spec.add_dependency 'ckeditor', '~> 4.1.2'
  spec.add_dependency 'date_validator', '~> 0.8.1'
  spec.add_dependency 'devise', '~> 3.5.1'
  spec.add_dependency 'draper', '~> 2.1.0'
  spec.add_dependency 'friendly_id', '~> 5.1.0'
  spec.add_dependency 'haml-rails', '~> 0.9.0'
  spec.add_dependency 'meta-tags', '~> 2.0.0'
  spec.add_dependency 'nested_form', '~> 0.3.2'
  spec.add_dependency 'paperclip', '~> 4.2.4'
  spec.add_dependency 'will_paginate-bootstrap', '~> 1.0.1'
  spec.add_dependency 'will_paginate', '~> 3.0.7'
  spec.add_dependency 'bootstrap_form', '~> 2.3.0'
  spec.add_dependency 'ransack', '~> 1.6.6'
  spec.add_dependency 'validate_url', '~> 1.0.0'
  spec.add_dependency 'font-awesome-sass', '~> 4.3.2'
  spec.add_dependency 'globalize', '~> 5.0.1'
  spec.add_dependency 'globalize-accessors', '~> 0.2.1'
  spec.add_dependency 'globalize-validations', '~> 0.0.4'
  spec.add_dependency 'omniauth', '~> 1.2.2'
  spec.add_dependency 'omniauth-twitter', '~> 1.2.1'
  spec.add_dependency 'omniauth-facebook', '~> 2.0.1'
  spec.add_dependency 'omniauth-instagram', '~> 1.0.1'
end
