class CreateOccurrences < ActiveRecord::Migration[6.0]
  def change
    create_table :occurrences do |t|
        t.string :date
        t.string :confirmed
        t.integer :deaths
        t.integer :recovered
        t.references :location, index: true
        t.timestamps
    end
  end
end
