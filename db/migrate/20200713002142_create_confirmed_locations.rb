class CreateConfirmedLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :province_state
      t.string :country_region
      t.integer :latitude
      t.integer :longitude
      t.timestamps
    end
  end
end