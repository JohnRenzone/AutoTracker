class CreateBatteries < ActiveRecord::Migration
  def change
    create_table :batteries do |t|
      t.belongs_to :vehicle_report_card, index: true
      t.string :battery_condition_legend
      t.float :factory_spec_amps
      t.float :actual_amps
      t.boolean :battery_serviced, default: false

      t.timestamps null: false
    end
  end
end
