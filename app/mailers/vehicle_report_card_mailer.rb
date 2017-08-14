class VehicleReportCardMailer < ApplicationMailer
  layout 'emails/vehicle_report_card'

  def email_report_card(vehicle_report_card, pdf, dealership)
    return false unless load_report(vehicle_report_card).present?
    attachments["report-#{vehicle_report_card.id}.pdf"] = {mime_type: 'application/pdf', content: pdf }

    @dealership = dealership

    mail to: @vehicle_report_card.customer_email, subject: "#{@dealership.try(:title) || 'Autotracker'} - Your Vehicle Service Report #{l(Time.zone.now, format: :date_only)}"
  end

  def notify_service_advisor(vehicle_report_card)
    @vehicle_report_card = vehicle_report_card
    @dealership = vehicle_report_card.service_advisor.dealership
    mail to: vehicle_report_card.service_advisor.email, subject: "[AutoTracker] #{vehicle_report_card.vehicle_identification_number} Report has been Submitted"
  end

  protected

  def load_report(vehicle_report_card)
    @vehicle_report_card = vehicle_report_card.is_a?(VehicleReportCard) ? vehicle_report_card : VehicleReportCard.find(vehicle_report_card)
  end
end