class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.references :category, index: true
      t.references :author, index: true
      t.boolean    :featured, null: false, default: false
      t.integer    :status, null: false, default: 0
      t.datetime   :published_at
      t.attachment :image

      t.timestamps
    end

    Article.create_translation_table! name: { type: :string, null: false, default: '' },
      description: :text,
      content: :text,
      slug: { type: :string, index: true, unique: true }

    add_foreign_key :articles, :categories
    add_foreign_key :articles, :authors
  end

  def down
    drop_table :articles
    Article.drop_translation_table!
  end
end
