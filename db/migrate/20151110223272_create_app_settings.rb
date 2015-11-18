class CreateAppSettings < ActiveRecord::Migration
  def self.up
    create_table :app_settings do |t|
      t.string  :description, null: false, default: 'Global'

      t.integer :contact_page_id
      t.string  :app_title
      t.text    :app_description

      t.string  :mailer_address
      t.integer :mailer_port
      t.string  :mailer_domain
      t.string  :mailer_user_name
      t.string  :mailer_name
      t.string  :mailer_password

      t.string  :inbox_name
      t.string  :inbox_email

      t.timestamps null: true
    end
  end

  def self.down
    drop_table :app_settings
  end
end
