class AddFieldsToProductsTable < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.references :brand, index: true
      t.integer :quantity, default: 0
      t.string :condition, default: 'new'
    end
    add_foreign_key :products, :brands
  end
end
