class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.integer    :status, null: false, default: 0
      t.integer    :priority, null: false, default: 0
      t.boolean    :featured, null: false, default: false
      t.string     :name
      t.string     :url
      t.boolean    :new_tab, null: false, default: false
      t.attachment :image

      t.timestamps
    end
  end
end
