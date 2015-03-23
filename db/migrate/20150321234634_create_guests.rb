class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.references :reservation, index: true
      t.string :name, null: false
      t.string :email
      t.integer :state, null: false
      t.string :dietary

      t.timestamps null: false
    end
    add_foreign_key :guests, :reservations
  end
end
