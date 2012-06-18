class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :book,     null: false
      t.datetime :timestamp,  null: false
      t.float :frequency
      t.string :band,         null: false
      t.string :mode,         null: false
      t.string :callsign,     null: false
      t.string :category,     null: false
      t.string :section,      null: false

      t.timestamps
    end
    add_index :contacts, [:book_id, :band, :mode, :callsign]
    add_index :contacts, [:book_id, :callsign]
  end
end
