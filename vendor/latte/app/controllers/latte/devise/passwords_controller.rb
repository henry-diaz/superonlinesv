class Latte::Devise::PasswordsController < Devise::PasswordsController
  layout 'latte/auth'

  before_action :metatags
  def metatags
    set_meta_tags title: LatteConfig[:sitename], site: 'Latte CMS', reverse: true
  end
end
