class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :creator
      t.string :title
      t.string :s3_key, limit: 2048, null: false
      t.string :url, limit: 2048
      t.datetime :processed_at
      t.string :thumb_s3_key, limit: 2048
      t.string :thumb_url, limit: 2048

      t.timestamps null: false
    end
  end
end
