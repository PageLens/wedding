class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :slug, null: false

      t.timestamps null: false
    end
    add_index :reservations, :slug, unique: true
  end
end
