class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.references :book, null: false
      t.string :name,     null: false

      t.timestamps
    end
    add_index :operators, [:book_id, :name], unqiue: true

    add_column :contacts, :primary_operator, :string
    add_column :contacts, :secondary_operator, :string
  end
end
