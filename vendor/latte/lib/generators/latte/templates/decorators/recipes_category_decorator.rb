class RecipesCategoryDecorator < Draper::Decorator
  delegate_all

  def recipes_category_id
    object.recipes_category_name
  end

  def status
    object.enabled? ?
      h.icon('check', class: 'text-success') :
      h.icon('close', class: 'text-danger')
  end
end
