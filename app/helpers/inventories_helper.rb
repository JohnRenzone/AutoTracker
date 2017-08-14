module InventoriesHelper
  def link_to_previous_report(vin)
    accessible_vehicle_report_cards_count = current_user.accessible_vehicle_report_cards.where(vehicle_identification_number: vin).count
    return 'No Previous Reports' if accessible_vehicle_report_cards_count.zero?

    link_to pluralize(accessible_vehicle_report_cards_count, 'Previous Report') + ' Found', vehicle_report_cards_path(vin: vin),
            target: :_blank,
            data: {toggle: 'tooltip', title: 'Click here to view Report(s)'}
  end
end