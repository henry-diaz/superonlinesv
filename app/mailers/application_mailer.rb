class ApplicationMailer < ActionMailer::Base

  ##
  # Default settings
  default from: "#{AppSetting.mailer_name} <#{AppSetting.mailer_user_name}>"

  ##
  # Layout
  layout 'mailer'
end
