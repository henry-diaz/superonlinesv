class CreateEventPrices < ActiveRecord::Migration
  def up
    create_table :event_prices do |t|
      t.references :event, index: true
      t.decimal    :price, precision: 8, scale: 2, null: false, default: 0.00

      t.timestamps
    end

    EventPrice.create_translation_table! name: { type: :string, null: false, default: '' }
    add_foreign_key :event_prices, :events
  end

  def down
    drop_table :event_prices
    EventPrice.drop_translation_table!
  end
end
