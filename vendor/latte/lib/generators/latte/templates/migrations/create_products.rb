class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.references :category, index: true
      t.boolean    :featured, null: false, default: false
      t.boolean    :exportation, null: false, default: false
      t.integer    :status, null: false, default: 0
      t.integer    :bundle_units, null: false, default: 0
      t.decimal    :gross_weight, precision: 8, scale: 2, null: false, default: 0.0
      t.decimal    :net_weight, precision: 8, scale: 2, null: false, default: 0.0
      t.decimal    :price, precision: 8, scale: 2, null: false, default: 0.00
      t.attachment :image

      t.timestamps
    end

    Product.create_translation_table! name: { type: :string, null: false, default: '' },
      slogan: { type: :string, null: false, default: '' },
      spec: :text,
      description: :text,
      slug: { type: :string, index: true, unique: true }

    add_foreign_key :products, :categories
  end

  def down
    drop_table :products
    Product.drop_translation_table!
  end
end
