class CreateWiperBlades < ActiveRecord::Migration
  def change
    create_table :wiper_blades do |t|
      t.belongs_to :vehicle_report_card, index: true
      t.boolean :wiper_test_performed, default: false
      t.string :wiper_blade_legend
      t.boolean :wiper_blade_serviced, default: false
      t.timestamps null: false
    end
  end
end
