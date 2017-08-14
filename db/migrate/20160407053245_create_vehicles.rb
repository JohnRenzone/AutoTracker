class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.references :vehicle_identification_number, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_column :vehicles, :deleted_at, :datetime
    add_index :vehicles, :deleted_at
  end
end
