class CreateConfirmedLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :province_state
      t.string :country
      t.integer :latitude
      t.integer :longitude
      t.timestamps
    end
  end
end