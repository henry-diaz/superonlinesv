class CreateRecipesCategories < ActiveRecord::Migration
  def up
    create_table :recipes_categories do |t|
      t.references :recipes_category, index: true
      t.integer    :status, null: false, default: 0
      t.integer    :priority, null: false, default: 0
      t.attachment :image

      t.timestamps
    end

    RecipesCategory.create_translation_table! name: { type: :string, null: false, default: '' },
      description: :text,
      slug: { type: :string, index: true, unique: true }

    add_foreign_key :recipes_categories, :recipes_categories
  end

  def down
    drop_table :recipes_categories
    RecipesCategory.drop_translation_table!
  end
end
