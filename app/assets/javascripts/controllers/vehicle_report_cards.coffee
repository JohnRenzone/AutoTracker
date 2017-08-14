$(document).ready ->
  $(window).keydown (event) ->
    if event.keyCode == 13
      event.preventDefault()
      $('#vehicle_report_card_vehicle_identification_number').focusout();
      return false