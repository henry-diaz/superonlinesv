class AddCreditCardNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_credit_card, :string
  end
end
