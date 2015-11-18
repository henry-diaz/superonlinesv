class AuthorDecorator < Draper::Decorator
  delegate_all

  def admin_id
    if admin.nil?
      '- -'
    else
      admin.name
    end
  end
end
