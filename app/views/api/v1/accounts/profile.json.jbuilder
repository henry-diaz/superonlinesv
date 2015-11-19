json.success @success
if @success
  json.user do
    json.name @user.try(:name)
    json.email @user.try(:email)
    json.address @user.try(:address)
    json.phone @user.try(:phone)
    json.set! 'credit-card', @user.try(:credit_card).to_s.split(//).last(4).join
  end
else
  json.user nil
end
