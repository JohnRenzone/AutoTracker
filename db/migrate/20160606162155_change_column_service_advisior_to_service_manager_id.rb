class ChangeColumnServiceAdvisiorToServiceManagerId < ActiveRecord::Migration
  def change
    remove_column :vehicle_report_cards, :service_advisor, :string
    add_column :vehicle_report_cards, :service_manager_id, :integer
  end
end
