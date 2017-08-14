class AddCustomerEmailToReportCard < ActiveRecord::Migration
  def change
    add_column :vehicle_report_cards, :customer_email, :string
  end
end
