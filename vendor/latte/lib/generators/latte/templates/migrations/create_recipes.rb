class CreateRecipes < ActiveRecord::Migration
  def up
    create_table :recipes do |t|
      t.references :recipes_category, index: true
      t.boolean    :featured, null: false, default: false
      t.integer    :status, null: false, default: 0
      t.integer    :priority, null: false, default: 0
      t.attachment :image

      t.timestamps
    end

    Recipe.create_translation_table! name: { type: :string, null: false, default: '' },
      description: :text,
      ingredients: :text,
      preparation: :text,
      slug: { type: :string, index: true, unique: true }

    add_foreign_key :recipes, :recipes_categories
  end

  def down
    drop_table :recipes
    Recipe.drop_translation_table!
  end
end
