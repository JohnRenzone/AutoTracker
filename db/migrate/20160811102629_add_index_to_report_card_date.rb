class AddIndexToReportCardDate < ActiveRecord::Migration
  def change
    add_index :vehicle_report_cards, :report_card_date
  end
end
