class CreateRadios < ActiveRecord::Migration
  def change
    create_table :radios do |t|
      t.references :book, null: false
      t.string :name,     null: false
      t.float :frequency

      t.timestamps
    end
    add_index :radios, [:book_id, :name], unique: true
  end
end
