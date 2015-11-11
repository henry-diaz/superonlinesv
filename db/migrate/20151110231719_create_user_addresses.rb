class CreateUserAddresses < ActiveRecord::Migration
  def change
    create_table :user_addresses do |t|
      t.references :user, index: true
      t.string :kind, index: true
      t.string :company_name
      t.string :email
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :zip
      t.references :city, index: true
      t.string :phone
      t.string :cellular
      t.string :fax
      t.timestamps null: false
    end
    add_foreign_key :user_addresses, :cities
    add_foreign_key :user_addresses, :users
  end
end
