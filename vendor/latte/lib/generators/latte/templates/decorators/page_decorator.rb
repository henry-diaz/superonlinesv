class PageDecorator < Draper::Decorator
  delegate_all

  def page_id
    object.page_name
  end

  def status
    object.enabled? ?
      h.icon('check', class: 'text-success') :
      h.icon('close', class: 'text-danger')
  end

  def in_navbar
    object.in_navbar? ?
      h.icon('check', class: 'text-success') :
      h.icon('close', class: 'text-danger')
  end

  def in_footer
    object.in_footer? ?
      h.icon('check', class: 'text-success') :
      h.icon('close', class: 'text-danger')
  end
end
