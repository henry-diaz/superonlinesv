class EventDecorator < Draper::Decorator
  delegate_all

  def category_id
    object.category_name
  end

  def status
    object.enabled? ?
      h.icon('check', class: 'text-success') :
      h.icon('close', class: 'text-danger')
  end

  def featured
    object.featured? ?
      h.icon('check', class: 'text-success') :
      h.icon('close', class: 'text-danger')
  end

  def start_at
    h.l object.start_at, format: :custom
  end

  def stop_at
    h.l object.stop_at, format: :custom
  end
end
