class AppMailer < ApplicationMailer
  ##
  # Send contact messages
  def contact(contact)
    @contact = contact
    mail(
      from:    "#{@contact.name} <#{@contact.email}>",
      to:      "#{AppSetting.inbox_name} <#{AppSetting.inbox_email}>",
      subject: "Contacto desde #{LatteConfig[:sitename]}"
    )
  end
end
