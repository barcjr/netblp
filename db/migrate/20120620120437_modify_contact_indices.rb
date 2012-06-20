class ModifyContactIndices < ActiveRecord::Migration
  def change
    remove_index :contacts, [:book_id, :callsign]
    add_index :contacts, [:book_id, :callsign, :category, :section]
  end
end
