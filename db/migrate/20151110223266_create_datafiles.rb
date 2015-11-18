class CreateDatafiles < ActiveRecord::Migration
  def up
    create_table :datafiles do |t|
      t.references :datafileable, polymorphic: true, index: true
      t.integer    :priority, null: false, default: 0
      t.attachment :image
      t.attachment :datafile

      t.timestamps
    end

    Datafile.create_translation_table! name: { type: :string, null: false, default: '' }, description: :text
  end

  def down
    drop_table :datafiles
    Datafile.drop_translation_table!
  end
end
