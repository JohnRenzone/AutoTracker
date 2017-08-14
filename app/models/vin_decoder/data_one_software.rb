# https://my.dataonesoftware.com

require 'net/http'
require 'net/https'

## Usage
#
# vin_decoder = VinDecoder::DataOneSoftware.new
# vin_decoder.decode(vin)
#
# if vin_decoder.has_errors?
#   puts vin_decoder.errors
# else
#   vin_decoder.response
# end

class VinDecoder::DataOneSoftware
  include UtilHelper

  attr_accessor :response, :errors

  def initialize()
    @auth_code = ENV['DATA_ONE_AUTH_CODE']
    @client_id = ENV['DATA_ONE_CLIENT_ID']
    @errors = []
  end

  def decode(vin)
    autotracker_log "Decoding VIN #{vin}....."

    # set up the http request
    https = Net::HTTP.new('api.dataonesoftware.com', 443)
    https.use_ssl = true

    # accept all SSL certificates
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # set the path to post to, data to post, and headers to send
    path = '/webservices/vindecoder/decode'
    request_data = "client_id=#{@client_id}&authorization_code=#{@auth_code}&decoder_query="

    request_data << "<decoder_query>
                         <decoder_settings>
                            <display>full</display>
                            <styles>on</styles>
                            <style_data_packs>
                               <basic_data>on</basic_data>
                               <pricing>on</pricing>
                               <engines>on</engines>
                               <transmissions>on</transmissions>
                               <specifications>on</specifications>
                               <installed_equipment>on</installed_equipment>
                               <optional_equipment>on</optional_equipment>
                               <generic_optional_equipment>on</generic_optional_equipment>
                               <colors>on</colors>
                               <warranties>on</warranties>
                               <fuel_efficiency>on</fuel_efficiency>
                               <green_scores>on</green_scores>
                               <crash_test>on</crash_test>
                            </style_data_packs>
                            <common_data>on</common_data>
                            <common_data_packs>
                               <basic_data>on</basic_data>
                               <pricing>on</pricing>
                               <engines>on</engines>
                               <transmissions>on</transmissions>
                               <specifications>on</specifications>
                               <installed_equipment>on</installed_equipment>
                               <generic_optional_equipment>on</generic_optional_equipment>
                            </common_data_packs>
                         </decoder_settings>
                         <query_requests>
                            <query_request identifier='#{SecureRandom.hex}'>
                               <vin>#{vin}</vin>
                               <year/>
                               <make/>
                               <model/>
                               <trim/>
                               <model_number/>
                               <package_code/>
                               <drive_type/>
                               <vehicle_type/>
                               <body_type/>
                               <doors/>
                               <bedlength/>
                               <wheelbase/>
                               <msrp/>
                               <invoice_price/>
                               <engine description=''>
                                  <block_type/>
                                  <cylinders/>
                                  <displacement/>
                                  <fuel_type/>
                               </engine>
                               <transmission description=''>
                                  <trans_type/>
                                  <trans_speeds/>
                               </transmission>
                               <optional_equipment_codes/>
                               <installed_equipment_descriptions/>
                               <interior_color description=''>
                                  <color_code/>
                               </interior_color>
                               <exterior_color description=''>
                                  <color_code/>
                               </exterior_color>
                            </query_request>
                         </query_requests>
                      </decoder_query>"
    headers ={'Content-Type' => 'application/x-www-form-urlencoded'}

    begin

      response = https.post(path, request_data, headers)

      body = response.body
          # to_s.
          # gsub(/<specification(.*?)>(.*?)<\/specification>/, "<specification#{$1}><value>#{$2}</value></specification>").
          # gsub(/<specification\/>/, "<specification><value/></specification>")

      @response = Hash.from_xml(body)

      autotracker_log @response
      autotracker_log "Successfuly decoded VIN #{vin}."

    rescue => e
      self.errors << {'code' => 500, 'message' => "Something terribly went wrong while decoding your vin. Please try again sometime later or contact support."}
      autotracker_log e.message
      autotracker_log e.backtrace
      autotracker_log e.message
    end
  end

  def has_errors?
    # decoder_errors
    query_response_errors

    autotracker_log "Finding errors if occured.."
    autotracker_log @errors

    @errors.present?
  end

  def attributes
    _attributes = response["decoded_data"]["query_responses"]["query_response"]['us_market_data']['us_styles']['style'].presence || {} rescue {}
    _attributes.is_a?(Array) ? _attributes.first : _attributes #Assuming we will be recevieng only one style per vin
  end

  def pricing_attributes
    (attributes.delete('pricing').presence || {}).slice(*Pricing.column_names)
  end

  def safety_equipment_attributes
    (attributes.delete('safety_equipment').presence || {}).slice(*SafetyEquipment.column_names)
  end

  def engines
    attributes.delete('engines') || {}
  end

  def engine_attributes
    [engines['engine'] || []].
        flatten.
        map { |engine| engine.merge('data_one_engine_id' => engine.delete('engine_id')).slice(*Engine.column_names) }
  end

  def epa_mpg_records_attributes
    epa_fuel_efficiency = attributes['epa_fuel_efficiency'] || {}
    [epa_fuel_efficiency.delete('epa_mpg_record') || []].
        flatten.
        map { |epa_mpg_record| epa_mpg_record.slice(*EpaMpgRecord.column_names) }
  end

  def epa_green_score_records_attributes
    epa_green_score = attributes['epa_green_scores'] || {}
    [epa_green_score.delete('epa_green_score_record') || []].
        flatten.
        map { |epa_green_score_record| epa_green_score_record.slice(*EpaGreenScoreRecord.column_names) }
  end

  def colors
    @colors ||= attributes.delete('colors').presence || {}
  end

  def exterior_colors_attributes
    [colors.delete('exterior_colors').try(:[], 'color') || []].
        flatten.
        map { |exterior_color| exterior_color.merge('type' => ExteriorColor.model_name.name).slice(*Color.column_names) }
  end

  def interior_colors_attributes
    [colors.delete('interior_colors').try(:[], 'color') || []].
        flatten.
        map { |exterior_color| exterior_color.merge('type' => InteriorColor.model_name.name).slice(*Color.column_names) }
  end

  def roof_colors_attributes
    [colors.delete('roof_colors').try(:[], 'color') || []].
        flatten.
        map { |exterior_color| exterior_color.merge('type' => RoofColor.model_name.name).slice(*Color.column_names) }
  end

  def transmissions
    attributes.delete('transmissions') || {}
  end

  def transmissions_attributes
    [transmissions['transmission'] || []].
        flatten.
        map { |transmission| transmission.merge('_type' => transmission.delete('type'), 'data_one_transmission_id' => transmission.delete('transmission_id')).slice(*Transmission.column_names) }

  end

  def warranties
    attributes.delete('warranties') || {}
  end

  def warranties_attributes
    [warranties['warranty'] || []].
        flatten.
        map { |warranty| warranty.merge('_type' => warranty.delete('type')).slice(*Warranty.column_names) }


  end

  def optional_equipments
    attributes.delete('optional_equipment') || []
  end

  def specifications
    attributes.delete('specifications') || []
  end

  def installed_equipments
    attributes.delete('installed_equipments') || []
  end

  def inventory_attributes
    inventory_attributes = (attributes.delete('basic_data') || {}).
        merge('data_one_vehicle_id' => attributes['vehicle_id']).
        slice(*Inventory.column_names)

    _attributes = inventory_attributes.merge(pricing_attributes: pricing_attributes,
                                             safety_equipment_attributes: safety_equipment_attributes,
                                             engines_attributes: engine_attributes,
                                             transmissions_attributes: transmissions_attributes,
                                             exterior_colors_attributes: exterior_colors_attributes,
                                             interior_colors_attributes: interior_colors_attributes,
                                             roof_colors_attributes: roof_colors_attributes,
                                             epa_mpg_records_attributes: epa_mpg_records_attributes,
                                             epa_green_score_records_attributes: epa_green_score_records_attributes,
                                             warranties_attributes: warranties_attributes)
    autotracker_log 'Final attributes after filtering'
    autotracker_log _attributes

    _attributes
  end

  private
  def decoder_errors
    return unless response

    decoder_errors = response["decoded_data"]["decoder_messages"]["decoder_errors"].presence
    self.errors << {'code' => decoder_errors.to_json, 'message' => decoder_errors.to_json, 'type' => 'DataOneDecoderErrorMessage'} if decoder_errors
  end

  def query_response_errors
    return unless response
    return unless response["decoded_data"]["query_responses"]

    code = response["decoded_data"]["query_responses"]["query_response"]["query_error"]["error_code"].presence
    message = response["decoded_data"]["query_responses"]["query_response"]["query_error"]["error_message"].presence

    self.errors << {'code' => code, 'message' => message, 'type' => 'DataOneQueryErrorMessage'} if code and message
  end
end