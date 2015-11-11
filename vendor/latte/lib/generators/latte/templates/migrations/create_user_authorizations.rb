class CreateUserAuthorizations < ActiveRecord::Migration
  def change
    create_table :user_authorizations do |t|
      t.references :user, index: true
      t.string     :provider, null: false, default: ''
      t.string     :uid,      null: false, default: ''
      t.string     :username, null: false, default: ''
      t.string     :token,    null: false, default: ''
      t.string     :secret,   null: false, default: ''

      t.timestamps
    end
    add_foreign_key :user_authorizations, :users
  end
end
