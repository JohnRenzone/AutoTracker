class ChangeColumnInVehicleComponent < ActiveRecord::Migration
  def change
    change_column :vehicle_components, :exhaust_system_legend,  :string
    add_column :vehicle_components, :exhaust_system_serviced, :boolean, :default =>  false
  end
end
