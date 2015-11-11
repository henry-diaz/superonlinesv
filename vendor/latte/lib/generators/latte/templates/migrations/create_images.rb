class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.references :imageable, polymorphic: true, index: true
      t.integer    :priority, null: false, default: 0
      t.attachment :image

      t.timestamps
    end

    Image.create_translation_table! name: { type: :string, null: false, default: '' }, description: :text
  end

  def down
    drop_table :images
    Image.drop_translation_table!
  end
end
