class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.references :page, index: true
      t.integer    :status, null: false, default: 0
      t.integer    :priority, null: false, default: 0
      t.boolean    :in_navbar, null: false, default: false
      t.boolean    :in_footer, null: false, default: false
      t.attachment :image

      t.timestamps
    end

    Page.create_translation_table! name: { type: :string, null: false, default: '' },
      description: :text,
      content: :text,
      slug: { type: :string, index: true, unique: true }

    add_foreign_key :pages, :pages
  end

  def down
    drop_table :pages
    Page.drop_translation_table!
  end
end
