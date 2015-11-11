class AddSkuFieldToProductsTable < ActiveRecord::Migration
  def change
    add_column :products, :sku, :string, index: true
    add_index :products, :sku
  end
end
