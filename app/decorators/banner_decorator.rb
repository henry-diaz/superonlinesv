class BannerDecorator < Draper::Decorator
  delegate_all

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
end
