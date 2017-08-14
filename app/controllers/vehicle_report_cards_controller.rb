class VehicleReportCardsController < ApplicationController
  include ApplicationHelper
  layout "application-pdf", only: [:show]

  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_instance_variables, only: [:create, :update, :new, :edit]
  before_action :set_report_card, only: [:edit, :update, :destroy, :download_pdf, :send_pdf, :email_pdf]
  before_action :mark_reviewed, only: :edit

  def index
    begin
      @vehicle_report_cards = VehicleReportCard.accessible_by(Ability.new current_user).joins(:user).includes(:user).order(params[:order].presence || 'vehicle_report_cards.created_at desc')
      @vehicle_report_cards = @vehicle_report_cards.where("users.last_name ILIKE '%#{params[:user]}%' or users.first_name ILIKE '%#{params[:user]}%' or users.username ILIKE '%#{params[:user]}%' or users.email ILIKE '%#{params[:user]}%'",) if params[:user].present?
      @vehicle_report_cards = @vehicle_report_cards.where("vehicle_report_cards.vehicle_identification_number ILIKE '%#{params[:vin]}%'") if params[:vin].present?

    rescue ArgumentError # as order is exposed. There might be cases where user might change the url
      @vehicle_report_cards = VehicleReportCard.none
    end
    @vehicle_report_cards = @vehicle_report_cards.page params[:page]
  end

  def new
    @vehicle_report_card = VehicleReportCard.new
    @vehicle_report_card.build_next_maintenance_appointment
    @vehicle_report_card.build_scheduled_maintenance_item
    @vehicle_report_card.build_fluid_level
    @vehicle_report_card.build_wiper_blade
    @vehicle_report_card.build_battery
    @vehicle_report_card.build_vehicle_component
    @vehicle_report_card.build_tire_wear_indicate
    @vehicle_report_card.build_brake_wear_indicate
  end

  def create
    @vehicle_report_card = VehicleReportCard.new(vehicle_report_card_params.merge(user_id: current_user.id))
    @vehicle_report_card.build_fluid_level if @vehicle_report_card.fluid_level.blank? #Hack
    respond_to do |format|
      if @vehicle_report_card.save
        format.html { redirect_to vehicle_report_cards_path, notice: 'New report created successfully.' }
        format.js
      else
        format.html { render 'new' }
        format.js
      end
    end
  end

  def edit
    @vehicle_report_card.build_fluid_level if @vehicle_report_card.fluid_level.blank?
  end

  def update
    respond_to do |format|
      if @vehicle_report_card.update_attributes(vehicle_report_card_params)
        format.html { redirect_to vehicle_report_cards_path, notice: 'Updated successfully.' }
        format.js { render 'send_pdf' } if request.format == 'text/javascript' && Rails.application.routes.recognize_path(request.referrer)[:action] == 'edit'
        format.js
      else
        format.html { render 'edit' }
        format.js
      end
    end
  end

  def destroy
    @vehicle_report_card.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_report_cards_path, notice: 'Report successfully destroyed.' }
    end
  end

  def show
    @vehicle_report_card.build_fluid_level if @vehicle_report_card.fluid_level.blank?
    generate_pdf(@vehicle_report_card)
    # respond_to do |format|
    #   format.html
    # end
  end

  def send_pdf
    respond_to do |format|
      format.js
    end
  end

  def email_pdf
    pdf = render_to_string pdf: "test", template: "vehicle_report_cards/show.html.haml"
    @vehicle_report_card.email_report(pdf)

    flash[:notice] = "Email has been sent successfully."
    redirect_to vehicle_report_cards_path
  end

  private

  def mark_reviewed
    @vehicle_report_card.review! if current_user.service_advisor? && @vehicle_report_card.to_be_reviewed?
  end

  def vehicle_report_card_params
    params.require(:vehicle_report_card).permit(:user_id, :report_card_date, :ro, :name, :email, :year, :make, :model, :vehicle_identification_number, :plate, :odometer, :owner_guide, :open_field_service_actions, :reset_oil_life_monitor, :service_advisor_id, :technician_id, :comments, :customer_declined_ford_maintanence, :exterior_body_note, :extended_service_plan, :owner_advantage_reward, :service_balance, :customer_email,
                                                :next_maintenance_appointment_attributes => [:id, :service_description, :appointment_date, :price, :appointment_time],
                                                :scheduled_maintenance_item_attributes => [:id, :the_works, :the_works_serviced, :oil_changes, :oil_changes_serviced, :tire_rotation, :tire_rotation_serviced, :multipoint_inspection, :multipoint_inspection_serviced, :fuel_filter, :fuel_filter_serviced, :engine_air_filter, :engine_air_filter_serviced, :engine_coolant_filter, :engine_coolant_filter_serviced, :transmission_fluid_filter, :transmission_fluid_filter_serviced, :cabin_air_filter, :cabin_air_filter_serviced, :spark_plugs, :spark_plugs_serviced, :km_scheduled_maintenance],
                                                :fluid_level_attributes => [:id, :fluid_levels_serviced, :engine_oil, :brake_reservoir, :power_steering, :window_washer, :transmission, :coolent_recovery_reservoir],
                                                :wiper_blade_attributes => [:id, :wiper_test_performed, :wiper_blade_legend, :wiper_blade_serviced],
                                                :battery_attributes => [:id, :battery_condition_legend, :factory_spec_amps, :actual_amps, :battery_serviced],
                                                :vehicle_component_attributes => [:id, :light_legend, :light_serviced, :windshield_legend, :windshield_serviced, :hvac_system_hoses_legend, :hvac_system_hoses_serviced, :engine_cooling_legend, :engine_cooling_serviced, :accessory_drive_belts_legend, :accessory_drive_belts_serviced, :brake_system_legend, :brake_system_serviced, :suspension_legend, :suspension_serviced, :steering_legend, :steering_serviced, :exhaust_system_legend, :exhaust_system_serviced, :clutch_legend, :clutch_legend_serviced, :constant_velocity_legend, :constant_velocity_serviced, :drive_shaft_legend, :drive_shaft_serviced],
                                                :tire_wear_indicate_attributes => [:id, :alignment_check_needed, :wheel_balance_needed, :left_front_tread_depth, :left_front_tread_depth_legend, :left_front_tread_depth_serviced, :left_front_pattern_legend, :left_front_pattern_serviced, :left_front_psi_legend, :left_front_psi_serviced, :left_front_tire_age, :left_rear_tread_depth, :left_rear_tread_depth_legend, :left_rear_tread_depth_serviced, :left_rear_pattern_legend, :left_rear_pattern_serviced, :left_rear_psi_legend, :left_rear_psi_serviced, :left_rear_tire_age, :right_front_tread_depth, :right_front_tread_depth_legend, :right_front_tread_depth_serviced, :right_front_pattern_legend, :right_front_pattern_serviced, :right_front_psi_legend, :right_front_psi_serviced, :right_front_tire_age, :right_rear_tread_depth, :right_rear_tread_depth_legend, :right_rear_tread_depth_serviced, :right_rear_pattern_legend, :right_rear_pattern_serviced, :right_rear_psi_legend, :right_rear_psi_serviced, :right_rear_tire_age, :spare_tire_age, :spare_tire_psi_legend, :spare_tire_serviced, :alignment_check_serviced, :wheel_balance_serviced],
                                                :brake_wear_indicate_attributes => [:id, :left_front_brake_lining, :left_front_legend, :left_front_serviced, :left_rear_brake_lining, :left_rear_legend, :left_rear_serviced, :right_front_brake_lining, :right_front_legend, :right_front_serviced, :right_rear_brake_lining, :right_rear_legend, :right_rear_serviced]
    )
  end

  def set_instance_variables
    @service_advisors = current_user.admin? ? User.service_advisor : current_user.dealership.users.service_advisors
    @technicians = current_user.admin? ? User.technician : current_user.dealership.users.technicians
  end

  def set_report_card
    @vehicle_report_card = VehicleReportCard.find(params[:id])
  end

end