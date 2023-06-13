class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title, null: false, index: true
      t.integer :year, null: false
      t.boolean :live, default: true, null: false
      t.references :band, foreign_key: {to_table: :bands}, null: false

      t.timestamps
    end
  end
end
