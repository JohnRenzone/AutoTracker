# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery_2
#= require jquery_ujs
#= require bootstrap
#= require moment
#= require bootstrap-datetimepicker
#= require pickers
#= require jquery.turbolinks
#= require turbolinks
#= require nprogress
#= require nprogress-turbolinks
#= require data-confirm-modal
#= require jquery.scrollto
#= require jquery-validation/dist/jquery.validate

$(document).ready ->
  jQuery(document).ajaxStart(->
    $("#progress").animate top: 0
  ).ajaxStop ->
    $("#progress").animate top: "-30px"

  $('form[data-jquery-validate]').validate()

  $('[data-toggle="popover"]').popover({html : true})

  $('[data-toggle="tooltip"]').tooltip()

  $('.btn-group > label.btn').on 'click', ->
    $(this).parent().children('label').addClass('backgroundGrey')
    $(this).parent().find('i').addClass('invisible')
    $(this).find('i').removeClass('invisible')

  #bind-twitter-bootstrap-tooltips-to-dynamically-created-elements
  $('body').tooltip({
    selector: '[data-toggle="tooltip"]'
  });

  $('.check-box-block').on 'click', ->
    checkbox = $(this).children('input[type=checkbox]')
    checkbox.prop("checked", !checkbox.prop("checked"))

    if checkbox.prop("checked")
      $(this).addClass('checked')
    else
      $(this).removeClass('checked')

  $('#vehicle_report_card_vehicle_identification_number').focusout ->
    if $('form[data-jquery-validate]').valid()
      $.ajax
        type: 'POST'
        url: '/inventories'
        data: 'inventory[vin]=' + $('#vehicle_report_card_vehicle_identification_number').val()
    else
      console.log 'Invalid form. Hence VIN data is not fetched.'

  $('#vehicle_report_card_vehicle_identification_number').keyup ->
    $(this).val $(this).val().toUpperCase()

$(document).ready ->
  $('.check-value input:radio').each ->
    if $(this).is(':checked')
      $(this).closest('label').addClass('active')
  return

$(document).ready ->
  $("#reportModal").modal("hide");

$(document).on 'click', '#btn-cancel', ->
  $("#email-div").hide();
  return


