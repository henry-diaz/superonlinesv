class CreateProductConnections < ActiveRecord::Migration
  def change
    create_table :product_connections, id: false do |t|
      t.integer :product_id
      t.integer :related_id
    end
    add_index :product_connections, [:product_id, :related_id]
  end
end
