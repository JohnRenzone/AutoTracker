class CreateVehicleIdentificationNumbers < ActiveRecord::Migration
  def change
    create_table :vehicle_identification_numbers do |t|
      t.string :number
      t.timestamps null: false
    end

    add_column :vehicle_identification_numbers, :deleted_at, :datetime
    add_index :vehicle_identification_numbers, :deleted_at
  end
end
