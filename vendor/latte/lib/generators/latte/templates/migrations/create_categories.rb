class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.references :category, index: true
      t.integer    :status, null: false, default: 0
      t.integer    :priority, null: false, default: 0
      t.string     :color, null: false, default: ''
      t.attachment :icon
      t.attachment :image

      t.timestamps
    end

    Category.create_translation_table! name: { type: :string, null: false, default: '' },
      description: :text,
      content: :text,
      slug: { type: :string, index: true, unique: true }

    add_foreign_key :categories, :categories
  end

  def down
    drop_table :categories
    Category.drop_translation_table!
  end
end
