class VehicleReportCardMailerPreview < ActionMailer::Preview

  def email_report_card
    VehicleReportCardMailer.email_report_card(VehicleReportCard.first,nil, Dealership.first)
  end
end