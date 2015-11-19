class OrderDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.try(:strftime, '%d/%m/%Y %I:%M%P')
  end

  def status
    case object.status
    when 'draft'
      'Sin pagar'
    else
      'Pagado'
    end
  end

  def code
    object.code
  end

  def user_id
    object.user.try(:name)
  end

  def amount
    h.number_to_currency object.amount
  end
end
