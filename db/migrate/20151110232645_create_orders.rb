class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status, default: 'draft'
      t.references :user, index: true
      t.references :shipping_address, index: true
      t.references :billing_address, index: true
      t.string :payment_method
      t.text :note
      t.float :discount
      t.timestamps null: false
    end
    add_foreign_key :orders, :users
    add_foreign_key :orders, :user_addresses, column: :shipping_address_id
    add_foreign_key :orders, :user_addresses, column: :billing_address_id
  end
end
