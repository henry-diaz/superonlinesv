# Requires
require 'rails/generators'
require 'rails/generators/migration'

#
class LatteGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
    if ActiveRecord::Base.timestamped_migrations
      [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
    else
      "%.3d" % next_migration_number
    end
  end

  def create_migrations
    migration_template 'migrations/create_admins.rb',
                       'db/migrate/create_admins.rb'

    migration_template 'migrations/create_users.rb',
                       'db/migrate/create_users.rb'

    migration_template 'migrations/create_user_authorizations.rb',
                       'db/migrate/create_user_authorizations.rb'

    migration_template 'migrations/create_categories.rb',
                       'db/migrate/create_categories.rb'

    migration_template 'migrations/create_authors.rb',
                       'db/migrate/create_authors.rb'

    migration_template 'migrations/create_articles.rb',
                       'db/migrate/create_articles.rb'

    migration_template 'migrations/create_events.rb',
                       'db/migrate/create_events.rb'

    migration_template 'migrations/create_event_prices.rb',
                       'db/migrate/create_event_prices.rb'

    migration_template 'migrations/create_images.rb',
                       'db/migrate/create_images.rb'

    migration_template 'migrations/create_videos.rb',
                       'db/migrate/create_videos.rb'

    migration_template 'migrations/create_datafiles.rb',
                       'db/migrate/create_datafiles.rb'

    migration_template 'migrations/create_products.rb',
                       'db/migrate/create_products.rb'

    migration_template 'migrations/create_pages.rb',
                       'db/migrate/create_pages.rb'

    migration_template 'migrations/create_banners.rb',
                       'db/migrate/create_banners.rb'

    migration_template 'migrations/create_recipes_categories.rb',
                       'db/migrate/create_recipes_categories.rb'

    migration_template 'migrations/create_recipes.rb',
                       'db/migrate/create_recipes.rb'

   migration_template 'migrations/create_app_settings.rb',
                      'db/migrate/create_app_settings.rb'

    migration_template 'migrations/create_ckeditor_assets.rb',
                       'db/migrate/create_ckeditor_assets.rb'

    migration_template 'migrations/acts_as_taggable_on_migration.rb',
                       'db/migrate/acts_as_taggable_on_migration.rb'

    migration_template 'migrations/add_missing_unique_indices.rb',
                       'db/migrate/add_missing_unique_indices.rb'

    migration_template 'migrations/add_taggings_counter_cache_to_tags.rb',
                       'db/migrate/add_taggings_counter_cache_to_tags.rb'

    migration_template 'migrations/add_missing_taggable_index.rb',
                       'db/migrate/add_missing_taggable_index.rb'

    migration_template 'migrations/change_collation_for_tag_names.rb',
                       'db/migrate/change_collation_for_tag_names.rb'
  end

  def copy_models
    copy_file 'models/admin.rb',
              'app/models/admin.rb'

    copy_file 'models/user.rb',
              'app/models/user.rb'

    copy_file 'models/user_authorization.rb',
              'app/models/user_authorization.rb'

    copy_file 'models/article.rb',
              'app/models/article.rb'

    copy_file 'models/author.rb',
              'app/models/author.rb'

    copy_file 'models/category.rb',
              'app/models/category.rb'

    copy_file 'models/event_price.rb',
              'app/models/event_price.rb'

    copy_file 'models/event.rb',
              'app/models/event.rb'

    copy_file 'models/page.rb',
              'app/models/page.rb'

    copy_file 'models/product.rb',
              'app/models/product.rb'

    copy_file 'models/banner.rb',
              'app/models/banner.rb'

    copy_file 'models/recipes_category.rb',
              'app/models/recipes_category.rb'

    copy_file 'models/recipe.rb',
              'app/models/recipe.rb'

    copy_file 'models/image.rb',
              'app/models/image.rb'

    copy_file 'models/video.rb',
              'app/models/video.rb'

    copy_file 'models/datafile.rb',
              'app/models/datafile.rb'

    copy_file 'models/app_setting.rb',
              'app/models/app_setting.rb'
  end

  def copy_decorators
    copy_file 'decorators/admin_decorator.rb',
              'app/decorators/admin_decorator.rb'

    copy_file 'decorators/user_decorator.rb',
              'app/decorators/user_decorator.rb'

    copy_file 'decorators/app_setting_decorator.rb',
              'app/decorators/app_setting_decorator.rb'

    copy_file 'decorators/article_decorator.rb',
              'app/decorators/article_decorator.rb'

    copy_file 'decorators/author_decorator.rb',
              'app/decorators/author_decorator.rb'

    copy_file 'decorators/category_decorator.rb',
              'app/decorators/category_decorator.rb'

    copy_file 'decorators/event_decorator.rb',
              'app/decorators/event_decorator.rb'

    copy_file 'decorators/page_decorator.rb',
              'app/decorators/page_decorator.rb'

    copy_file 'decorators/product_decorator.rb',
              'app/decorators/product_decorator.rb'

    copy_file 'decorators/banner_decorator.rb',
              'app/decorators/banner_decorator.rb'

    copy_file 'decorators/recipes_category_decorator.rb',
              'app/decorators/recipes_category_decorator.rb'

    copy_file 'decorators/recipe_decorator.rb',
              'app/decorators/recipe_decorator.rb'
  end

  def copy_mailer_files
    copy_file 'mailer/app_mailer.rb',
              'app/mailers/app_mailer.rb'

    copy_file 'mailer/application_mailer.rb',
              'app/mailers/application_mailer.rb'

    copy_file 'mailer/contact.rb',
              'app/models/contact.rb'

    copy_file 'mailer/contact.text.haml',
              'app/views/app_mailer/contact.text.haml'

    copy_file 'mailer/contacts_controller.rb',
              'app/controllers/contacts_controller.rb'

    copy_file 'mailer/mailer.html.haml',
              'app/views/layouts/mailer.html.haml'

    copy_file 'mailer/mailer.text.haml',
              'app/views/layouts/mailer.text.haml'
  end

  def copy_configuration_files
    copy_file 'config/latte.yml',
              'config/latte.yml'
  end

  def copy_initializers_files
    copy_file 'config/initializers/devise.rb',
              'config/initializers/devise.rb'

    copy_file 'config/initializers/inline_errors.rb',
              'config/initializers/inline_errors.rb'

    copy_file 'config/initializers/latte.rb',
              'config/initializers/latte.rb'

    copy_file 'config/initializers/action_mailer.rb',
              'config/initializers/action_mailer.rb'

    copy_file Rails.root.join('config/database.yml'),
              'config/database.yml.sample'
  end

  def inject_lines
    ##
    # Edit config/initializers/assets.rb
    inject_into_file 'config/initializers/assets.rb', after: /\z/ do <<-'RUBY'
Rails.application.config.assets.precompile += %w( ckeditor/* )
    RUBY
    end

    ##
    # Edit config/enviroments/development.rb
    application(nil, env: 'development') do
      "\n  # Mailer configuration\n  config.action_mailer.default_url_options = { host: 'localhost:3000' }\n"
    end

    ##
    # Edit config/application.rb
    application(nil) do
      "\n    # Fallback translations\n    config.i18n.fallbacks = true\n"
    end

    application(nil) do
      "\n    config.i18n.default_locale = LatteConfig[:languages].first"
    end

    ##
    # Create .gitignore if doesn't exist
    File.new('.gitignore', 'w') unless File.exists? '.gitignore'

    ##
    # Edit .gitignore
    ignores = %w(
      /.bundle
      /.git
      /config/database.yml
      /config/deploy.rb
      /config/deploy/production.rb
      /db/schema.rb
      /log/*.log
      /public/ckeditor_assets
      /public/sitemap.xml.gz
      /public/system
      /tmp
    )
    inject_into_file '.gitignore', after: /\z/ do
      ignores.join("\n")
    end
  end

  def install_devise_for_users
    ##
    # Add devise user routes
    route "\n  devise_for :users, controllers: { sessions: 'auth/sessions', registrations: 'auth/registrations', passwords: 'auth/passwords', omniauth_callbacks: 'auth/omniauth_callbacks' }"

    ##
    # Copy controllers
    directory 'auth/controllers', 'app/controllers/auth'

    ##
    # Copy views
    directory 'auth/views', 'app/views/auth'
  end
end
