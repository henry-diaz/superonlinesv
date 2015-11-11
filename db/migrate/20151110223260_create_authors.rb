class CreateAuthors < ActiveRecord::Migration
  def up
    create_table :authors do |t|
      t.references :admin, index: true
      t.string     :name,         null: false, default: ''
      t.string     :website_url,  null: false, default: ''
      t.string     :twitter_url,  null: false, default: ''
      t.string     :facebook_url, null: false, default: ''
      t.string     :linkedin_url, null: false, default: ''
      t.string     :gplus_url,    null: false, default: ''
      t.string     :youtube_url,  null: false, default: ''
      t.attachment :image

      t.timestamps
    end

    Author.create_translation_table! about: :text,
      slug: { type: :string, index: true, unique: true }

    add_foreign_key :authors, :admins
  end

  def down
    drop_table :authors
    Author.drop_translation_table!
  end
end
