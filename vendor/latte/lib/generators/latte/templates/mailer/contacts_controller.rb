class ContactsController < ApplicationController

  def create
    @contact = Contact.new params[:contact]
    @page    = Page.find AppSetting.contact_page_id

    if @contact.valid?
      @contact.deliver
      redirect_to page_url(@page), sent: true
    else
      render template: 'pages/show', id: @page
    end
  end
end
