class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.references :videoable, polymorphic: true, index: true
      t.integer    :priority, null: false, default: 0
      t.string     :url
      t.attachment :image
      t.attachment :video

      t.timestamps
    end

    Video.create_translation_table! name: { type: :string, null: false, default: '' }, description: :text
  end

  def down
    drop_table :videos
    Video.drop_translation_table!
  end
end
