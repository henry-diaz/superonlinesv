class Auth::RegistrationsController < Devise::RegistrationsController
  ##
  # Create layout if necessary
  #
  # layout 'devise'

  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :username
  end
end
