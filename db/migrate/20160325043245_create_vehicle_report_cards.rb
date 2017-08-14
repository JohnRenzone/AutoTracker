class CreateVehicleReportCards < ActiveRecord::Migration
  def change
    create_table :vehicle_report_cards do |t|
      t.date :report_card_date, null: false
      t.integer :ro, null: false
      t.string :name, null: false
      t.string :email, null: false, default: ''
      t.integer :year
      t.integer :make
      t.integer :model, index: true
      t.string :vehicle_identification_number, null: false, unique: true
      t.integer :plate
      t.float :odometer, null: false
      t.boolean :owner_guide, default: false
      t.boolean :open_field_service_actions, default: false
      t.boolean :reset_oil_life_monitor, default: false
      t.string :service_advisor, null: false
      t.string :technician, null: false
      t.text :comments
      t.boolean :customer_declined_ford_maintanence, default: false
      t.text :exterior_body_note
      t.boolean :extended_service_plan, default: false
      t.integer :owner_advantage_reward
      t.float :service_balance

      t.timestamps null: false
    end
  end
end
