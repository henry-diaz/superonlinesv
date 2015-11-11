class ProductDecorator < Draper::Decorator
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

  def price
    h.number_to_currency object.price
  end
end
