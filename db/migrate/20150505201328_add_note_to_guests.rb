class AddNoteToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :note, :text
  end
end
