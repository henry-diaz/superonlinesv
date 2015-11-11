class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :kind, default: 'amount'
      t.integer :quantity
      t.references :product, index: true
      t.boolean :by_percentage, default: false
      t.float :discount
      t.boolean :active, default: true
      t.timestamps null: false
    end
    add_foreign_key :promotions, :products
  end
end
