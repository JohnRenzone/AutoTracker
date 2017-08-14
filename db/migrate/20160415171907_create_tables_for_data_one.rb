class CreateTablesForDataOne < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :vin, :data_one_vehicle_id
      t.string :market,
               :year,
               :make,
               :model,
               :trim,
               :vehicle_type,
               :body_type,
               :body_subtype,
               :oem_body_style,
               :doors,
               :oem_doors,
               :model_number,
               :package_code,
               :drive_type,
               :brake_system,
               :restraint_type,
               :country_of_manufacture,
               :plant,
               :glider,
               :chassis_type,
               :complete,
               :fleet

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :engines do |t|
      t.integer :data_one_engine_id
      t.string :brand
      t.string :marketing_name
      t.string :availability
      t.string :aspiration
      t.string :block_type
      t.decimal :bore, precision: 10, scale: 2
      t.string :cam_type
      t.decimal :compression, precision: 10, scale: 2
      t.integer :cylinders
      t.decimal :displacement, precision: 10, scale: 2
      t.string :fuel_induction
      t.integer :fuel_quality
      t.string :fuel_type
      t.integer :msrp
      t.integer :invoice_price
      t.string :marketing_name
      t.integer :max_hp
      t.integer :max_hp_at
      t.string :max_payload
      t.integer :max_torque
      t.integer :max_torque_at
      t.decimal :oil_capacity, precision: 10, scale: 2
      t.string :order_code
      t.string :redline
      t.decimal :stroke, precision: 10, scale: 2
      t.string :valve_timing
      t.integer :valves

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :transmissions do |t|
      t.integer :data_one_transmission_id

      t.string :branch
      t.string :marketing_name
      t.string :availability
      t.string :_type
      t.string :detail_type
      t.integer :gears
      t.string :order_code
      t.integer :msrp
      t.integer :invoice_price

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :categories do |t|
      t.string :name

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :equipments do |t|
      t.string :name
      t.integer :category_id

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :specifications do |t|
      t.string :name
      t.integer :category_id

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :options do |t|
      t.string :name
      t.string :order_code
      t.string :installed
      t.integer :data_one_option_id
      t.text :description

      t.integer :category_id

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :pricings do |t|
      t.integer :inventory_id

      t.integer :msrp, :invoice_price, :destination_charge, :gas_guzzler_tax

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :colors do |t|
      t.integer :inventory_id

      t.string :mfr_code
      t.string :generic_color_name
      t.string :mfr_color_name
      t.string :primary_rgb_code
      t.string :secondary_rgb_code
      t.string :type


      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :warranties do |t|
      t.integer :inventory_id

      t.string :name
      t.string :_type
      t.string :months
      t.string :miles

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :epa_mpg_records do |t|
      t.integer :inventory_id

      t.string :city
      t.string :highway
      t.string :combined

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :epa_green_score_records do |t|
      t.integer :inventory_id

      t.string :emissions_standard
      t.string :air_pollution_score
      t.string :greenhouse_gas_score
      t.string :smartway

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :safety_equipments do |t|
      t.integer :inventory_id

      t.integer :abs_two_wheel
      t.integer :abs_four_wheel
      t.integer :airbags_front_driver
      t.integer :airbags_front_passenger
      t.integer :airbags_side_impact
      t.integer :airbags_side_curtain
      t.integer :brake_assist
      t.integer :daytime_running_lights
      t.integer :electronic_stability_control
      t.integer :electronic_traction_control
      t.integer :tire_pressure_monitoring_system
      t.integer :rollover_stability_control


      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :data_one_failed_quieres do |t|
      t.string :vin
      t.integer :data_one_query_error_message_id, :data_one_decoder_error_message_id


      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :data_one_error_messages do |t|
      t.string :type, :code, :message

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :inventories_specifications do |t|
      t.integer :inventory_id
      t.integer :specification_id

      t.string :value

      t.timestamps null: false
      t.timestamp :deleted_at
    end


    create_table :inventories_options do |t|
      t.integer :inventory_id
      t.integer :option_id

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :engines_inventories do |t|
      t.integer :inventory_id
      t.integer :engine_id

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :inventories_transmissions do |t|
      t.integer :inventory_id
      t.integer :transmission_id

      t.timestamps null: false
      t.timestamp :deleted_at
    end

    create_table :equipments_inventories do |t|
      t.integer :inventory_id
      t.integer :equipment_id

      t.integer :value

      t.timestamps null: false
      t.timestamp :deleted_at
    end

  end
end
