class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.references :category, index: true
      t.boolean    :featured, null: false, default: false
      t.integer    :status, null: false, default: 0
      t.datetime   :start_at
      t.datetime   :stop_at
      t.decimal    :price, precision: 8, scale: 2, null: false, default: 0.00
      t.attachment :image

      t.timestamps
    end

    Event.create_translation_table! name: { type: :string, null: false, default: '' },
      description: :text,
      content: :text,
      place: { type: :string, null: false, default: '' },
      slug: { type: :string, index: true, unique: true }

    add_foreign_key :events, :categories
  end

  def down
    drop_table :events
    Event.drop_translation_table!
  end
end
