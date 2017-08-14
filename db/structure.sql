--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authentications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    user_id integer,
    provider character varying NOT NULL,
    proid character varying NOT NULL,
    token character varying,
    refresh_token character varying,
    secret character varying,
    expires_at timestamp without time zone,
    username character varying,
    image_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: batteries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE batteries (
    id integer NOT NULL,
    vehicle_report_card_id integer,
    battery_condition_legend character varying,
    factory_spec_amps integer,
    actual_amps integer,
    battery_serviced boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: batteries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE batteries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: batteries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE batteries_id_seq OWNED BY batteries.id;


--
-- Name: brake_wear_indicates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE brake_wear_indicates (
    id integer NOT NULL,
    vehicle_report_card_id integer,
    left_front_brake_lining integer,
    left_front_legend character varying,
    left_front_serviced boolean DEFAULT false,
    left_rear_brake_lining integer,
    left_rear_legend character varying,
    left_rear_serviced boolean DEFAULT false,
    right_front_brake_lining integer,
    right_front_legend character varying,
    right_front_serviced boolean DEFAULT false,
    right_rear_brake_lining integer,
    right_rear_legend character varying,
    right_rear_serviced boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: brake_wear_indicates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE brake_wear_indicates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brake_wear_indicates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE brake_wear_indicates_id_seq OWNED BY brake_wear_indicates.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: colors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE colors (
    id integer NOT NULL,
    inventory_id integer,
    mfr_code character varying,
    generic_color_name character varying,
    mfr_color_name character varying,
    primary_rgb_code character varying,
    secondary_rgb_code character varying,
    type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: colors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE colors_id_seq OWNED BY colors.id;


--
-- Name: data_one_error_messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE data_one_error_messages (
    id integer NOT NULL,
    type character varying,
    code character varying,
    message character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: data_one_error_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE data_one_error_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: data_one_error_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE data_one_error_messages_id_seq OWNED BY data_one_error_messages.id;


--
-- Name: data_one_failed_quieres; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE data_one_failed_quieres (
    id integer NOT NULL,
    vin character varying,
    data_one_query_error_message_id integer,
    data_one_decoder_error_message_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: data_one_failed_quieres_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE data_one_failed_quieres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: data_one_failed_quieres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE data_one_failed_quieres_id_seq OWNED BY data_one_failed_quieres.id;


--
-- Name: dealerships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dealerships (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    title character varying,
    address text,
    identifier character varying
);


--
-- Name: dealerships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dealerships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dealerships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dealerships_id_seq OWNED BY dealerships.id;


--
-- Name: engines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE engines (
    id integer NOT NULL,
    data_one_engine_id integer,
    brand character varying,
    marketing_name character varying,
    availability character varying,
    aspiration character varying,
    block_type character varying,
    bore numeric(10,2),
    cam_type character varying,
    compression numeric(10,2),
    cylinders integer,
    displacement numeric(10,2),
    fuel_induction character varying,
    fuel_quality integer,
    fuel_type character varying,
    msrp integer,
    invoice_price integer,
    max_hp integer,
    max_hp_at integer,
    max_payload character varying,
    max_torque integer,
    max_torque_at integer,
    oil_capacity numeric(10,2),
    order_code character varying,
    redline character varying,
    stroke numeric(10,2),
    valve_timing character varying,
    valves integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: engines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE engines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: engines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE engines_id_seq OWNED BY engines.id;


--
-- Name: engines_inventories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE engines_inventories (
    id integer NOT NULL,
    inventory_id integer,
    engine_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: engines_inventories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE engines_inventories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: engines_inventories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE engines_inventories_id_seq OWNED BY engines_inventories.id;


--
-- Name: epa_green_score_records; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE epa_green_score_records (
    id integer NOT NULL,
    inventory_id integer,
    emissions_standard character varying,
    air_pollution_score character varying,
    greenhouse_gas_score character varying,
    smartway character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: epa_green_score_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE epa_green_score_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: epa_green_score_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE epa_green_score_records_id_seq OWNED BY epa_green_score_records.id;


--
-- Name: epa_mpg_records; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE epa_mpg_records (
    id integer NOT NULL,
    inventory_id integer,
    city character varying,
    highway character varying,
    combined character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: epa_mpg_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE epa_mpg_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: epa_mpg_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE epa_mpg_records_id_seq OWNED BY epa_mpg_records.id;


--
-- Name: equipments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE equipments (
    id integer NOT NULL,
    name character varying,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: equipments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE equipments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equipments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE equipments_id_seq OWNED BY equipments.id;


--
-- Name: equipments_inventories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE equipments_inventories (
    id integer NOT NULL,
    inventory_id integer,
    equipment_id integer,
    value integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: equipments_inventories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE equipments_inventories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equipments_inventories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE equipments_inventories_id_seq OWNED BY equipments_inventories.id;


--
-- Name: fluid_levels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fluid_levels (
    id integer NOT NULL,
    vehicle_report_card_id integer,
    fluid_levels_serviced boolean DEFAULT false,
    engine_oil character varying,
    brake_reservoir character varying,
    power_steering character varying,
    window_washer character varying,
    transmission character varying,
    coolent_recovery_reservoir character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: fluid_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fluid_levels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fluid_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fluid_levels_id_seq OWNED BY fluid_levels.id;


--
-- Name: inventories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inventories (
    id integer NOT NULL,
    vin character varying,
    data_one_vehicle_id integer,
    market character varying,
    year character varying,
    make character varying,
    model character varying,
    "trim" character varying,
    vehicle_type character varying,
    body_type character varying,
    body_subtype character varying,
    oem_body_style character varying,
    doors character varying,
    oem_doors character varying,
    model_number character varying,
    package_code character varying,
    drive_type character varying,
    brake_system character varying,
    restraint_type character varying,
    country_of_manufacture character varying,
    plant character varying,
    glider character varying,
    chassis_type character varying,
    complete character varying,
    fleet character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: inventories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inventories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inventories_id_seq OWNED BY inventories.id;


--
-- Name: inventories_options; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inventories_options (
    id integer NOT NULL,
    inventory_id integer,
    option_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: inventories_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inventories_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventories_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inventories_options_id_seq OWNED BY inventories_options.id;


--
-- Name: inventories_specifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inventories_specifications (
    id integer NOT NULL,
    inventory_id integer,
    specification_id integer,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: inventories_specifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inventories_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventories_specifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inventories_specifications_id_seq OWNED BY inventories_specifications.id;


--
-- Name: inventories_transmissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inventories_transmissions (
    id integer NOT NULL,
    inventory_id integer,
    transmission_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: inventories_transmissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inventories_transmissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventories_transmissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inventories_transmissions_id_seq OWNED BY inventories_transmissions.id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE items (
    id integer NOT NULL,
    vehicle_id integer,
    key character varying,
    value text,
    unit character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE items_id_seq OWNED BY items.id;


--
-- Name: next_maintenance_appointments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE next_maintenance_appointments (
    id integer NOT NULL,
    service_description character varying,
    appointment_date timestamp without time zone,
    price numeric,
    appointment_time time without time zone,
    vehicle_report_card_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: next_maintenance_appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE next_maintenance_appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: next_maintenance_appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE next_maintenance_appointments_id_seq OWNED BY next_maintenance_appointments.id;


--
-- Name: oauth_caches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oauth_caches (
    authentication_id integer NOT NULL,
    data_json text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: options; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE options (
    id integer NOT NULL,
    name character varying,
    order_code character varying,
    installed character varying,
    data_one_option_id integer,
    description text,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE options_id_seq OWNED BY options.id;


--
-- Name: pricings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pricings (
    id integer NOT NULL,
    inventory_id integer,
    msrp integer,
    invoice_price integer,
    destination_charge integer,
    gas_guzzler_tax integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: pricings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pricings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pricings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pricings_id_seq OWNED BY pricings.id;


--
-- Name: rails_admin_histories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rails_admin_histories (
    id integer NOT NULL,
    message text,
    username character varying,
    item integer,
    "table" character varying,
    month smallint,
    year bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rails_admin_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rails_admin_histories_id_seq OWNED BY rails_admin_histories.id;


--
-- Name: safety_equipments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE safety_equipments (
    id integer NOT NULL,
    inventory_id integer,
    abs_two_wheel integer,
    abs_four_wheel integer,
    airbags_front_driver integer,
    airbags_front_passenger integer,
    airbags_side_impact integer,
    airbags_side_curtain integer,
    brake_assist integer,
    daytime_running_lights integer,
    electronic_stability_control integer,
    electronic_traction_control integer,
    tire_pressure_monitoring_system integer,
    rollover_stability_control integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: safety_equipments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE safety_equipments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: safety_equipments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE safety_equipments_id_seq OWNED BY safety_equipments.id;


--
-- Name: scheduled_maintenance_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE scheduled_maintenance_items (
    id integer NOT NULL,
    vehicle_report_card_id integer,
    the_works boolean DEFAULT false,
    the_works_serviced boolean DEFAULT false,
    oil_changes boolean DEFAULT false,
    oil_changes_serviced boolean DEFAULT false,
    tire_rotation boolean DEFAULT false,
    tire_rotation_serviced boolean DEFAULT false,
    multipoint_inspection boolean DEFAULT false,
    multipoint_inspection_serviced boolean DEFAULT false,
    fuel_filter boolean DEFAULT false,
    fuel_filter_serviced boolean DEFAULT false,
    engine_air_filter boolean DEFAULT false,
    engine_air_filter_serviced boolean DEFAULT false,
    engine_coolant_filter boolean DEFAULT false,
    engine_coolant_filter_serviced boolean DEFAULT false,
    transmission_fluid_filter boolean DEFAULT false,
    transmission_fluid_filter_serviced boolean DEFAULT false,
    cabin_air_filter boolean DEFAULT false,
    cabin_air_filter_serviced boolean DEFAULT false,
    spark_plugs boolean DEFAULT false,
    spark_plugs_serviced boolean DEFAULT false,
    km_scheduled_maintenance double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: scheduled_maintenance_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE scheduled_maintenance_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scheduled_maintenance_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE scheduled_maintenance_items_id_seq OWNED BY scheduled_maintenance_items.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: specifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE specifications (
    id integer NOT NULL,
    name character varying,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: specifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: specifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE specifications_id_seq OWNED BY specifications.id;


--
-- Name: tire_wear_indicates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tire_wear_indicates (
    id integer NOT NULL,
    vehicle_report_card_id integer,
    alignment_check_needed boolean DEFAULT false,
    wheel_balance_needed boolean DEFAULT false,
    left_front_tread_depth integer,
    left_front_tread_depth_legend character varying,
    left_front_tread_depth_serviced boolean DEFAULT false,
    left_front_pattern_legend character varying,
    left_front_pattern_serviced boolean DEFAULT false,
    left_front_psi_legend character varying,
    left_front_psi_serviced boolean DEFAULT false,
    left_front_tire_age double precision,
    left_rear_tread_depth integer,
    left_rear_tread_depth_legend character varying,
    left_rear_tread_depth_serviced boolean DEFAULT false,
    left_rear_pattern_legend character varying,
    left_rear_pattern_serviced boolean DEFAULT false,
    left_rear_psi_legend character varying,
    left_rear_psi_serviced boolean DEFAULT false,
    left_rear_tire_age double precision,
    right_front_tread_depth integer,
    right_front_tread_depth_legend character varying,
    right_front_tread_depth_serviced boolean DEFAULT false,
    right_front_pattern_legend character varying,
    right_front_pattern_serviced boolean DEFAULT false,
    right_front_psi_legend character varying,
    right_front_psi_serviced boolean DEFAULT false,
    right_front_tire_age double precision,
    right_rear_tread_depth integer,
    right_rear_tread_depth_legend character varying,
    right_rear_tread_depth_serviced boolean DEFAULT false,
    right_rear_pattern_legend character varying,
    right_rear_pattern_serviced boolean DEFAULT false,
    right_rear_psi_legend character varying,
    right_rear_psi_serviced boolean DEFAULT false,
    right_rear_tire_age double precision,
    spare_tire_age double precision,
    spare_tire_psi_legend character varying,
    spare_tire_serviced boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    alignment_check_serviced boolean,
    wheel_balance_serviced boolean,
    deleted_at timestamp without time zone
);


--
-- Name: tire_wear_indicates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tire_wear_indicates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tire_wear_indicates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tire_wear_indicates_id_seq OWNED BY tire_wear_indicates.id;


--
-- Name: transmissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE transmissions (
    id integer NOT NULL,
    data_one_transmission_id integer,
    branch character varying,
    marketing_name character varying,
    availability character varying,
    _type character varying,
    detail_type character varying,
    gears integer,
    order_code character varying,
    msrp integer,
    invoice_price integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: transmissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transmissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transmissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transmissions_id_seq OWNED BY transmissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    image_url character varying,
    email character varying DEFAULT ''::character varying,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_id integer,
    invited_by_type character varying,
    invitations_count integer DEFAULT 0,
    deleted_at timestamp without time zone,
    role integer DEFAULT 1,
    username character varying DEFAULT ''::character varying,
    dealership_id integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: vehicle_components; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vehicle_components (
    id integer NOT NULL,
    vehicle_report_card_id integer,
    light_legend character varying,
    light_serviced boolean DEFAULT false,
    windshield_legend character varying,
    windshield_serviced boolean DEFAULT false,
    hvac_system_hoses_legend character varying,
    hvac_system_hoses_serviced boolean DEFAULT false,
    engine_cooling_legend character varying,
    engine_cooling_serviced boolean DEFAULT false,
    accessory_drive_belts_legend character varying,
    accessory_drive_belts_serviced boolean DEFAULT false,
    brake_system_legend character varying,
    brake_system_serviced boolean DEFAULT false,
    suspension_legend character varying,
    suspension_serviced boolean DEFAULT false,
    steering_legend character varying,
    steering_serviced boolean DEFAULT false,
    exhaust_system_legend character varying DEFAULT false,
    clutch_legend character varying,
    clutch_legend_serviced boolean DEFAULT false,
    constant_velocity_legend character varying,
    constant_velocity_serviced boolean DEFAULT false,
    drive_shaft_legend character varying,
    drive_shaft_serviced boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    exhaust_system_serviced boolean DEFAULT false,
    deleted_at timestamp without time zone
);


--
-- Name: vehicle_components_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE vehicle_components_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vehicle_components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE vehicle_components_id_seq OWNED BY vehicle_components.id;


--
-- Name: vehicle_identification_numbers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vehicle_identification_numbers (
    id integer NOT NULL,
    number character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: vehicle_identification_numbers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE vehicle_identification_numbers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vehicle_identification_numbers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE vehicle_identification_numbers_id_seq OWNED BY vehicle_identification_numbers.id;


--
-- Name: vehicle_report_cards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vehicle_report_cards (
    id integer NOT NULL,
    report_card_date timestamp without time zone,
    ro integer,
    name character varying,
    email character varying DEFAULT ''::character varying,
    year integer,
    make character varying,
    model character varying,
    vehicle_identification_number character varying NOT NULL,
    plate integer,
    odometer bigint,
    owner_guide boolean DEFAULT false,
    open_field_service_actions boolean DEFAULT false,
    reset_oil_life_monitor boolean DEFAULT false,
    comments text,
    customer_declined_ford_maintanence boolean DEFAULT false,
    extended_service_plan boolean DEFAULT false,
    owner_advantage_reward integer,
    service_balance double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    attachment character varying,
    deleted_at timestamp without time zone,
    customer_email character varying,
    service_advisor_id integer,
    technician_id integer,
    aasm_state character varying
);


--
-- Name: vehicle_report_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE vehicle_report_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vehicle_report_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE vehicle_report_cards_id_seq OWNED BY vehicle_report_cards.id;


--
-- Name: vehicles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vehicles (
    id integer NOT NULL,
    vehicle_identification_number_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: vehicles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE vehicles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vehicles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE vehicles_id_seq OWNED BY vehicles.id;


--
-- Name: warranties; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE warranties (
    id integer NOT NULL,
    inventory_id integer,
    name character varying,
    _type character varying,
    months character varying,
    miles character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: warranties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE warranties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: warranties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE warranties_id_seq OWNED BY warranties.id;


--
-- Name: wiper_blades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wiper_blades (
    id integer NOT NULL,
    vehicle_report_card_id integer,
    wiper_test_performed boolean DEFAULT false,
    wiper_blade_legend character varying,
    wiper_blade_serviced boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: wiper_blades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wiper_blades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiper_blades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wiper_blades_id_seq OWNED BY wiper_blades.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY batteries ALTER COLUMN id SET DEFAULT nextval('batteries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY brake_wear_indicates ALTER COLUMN id SET DEFAULT nextval('brake_wear_indicates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY colors ALTER COLUMN id SET DEFAULT nextval('colors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY data_one_error_messages ALTER COLUMN id SET DEFAULT nextval('data_one_error_messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY data_one_failed_quieres ALTER COLUMN id SET DEFAULT nextval('data_one_failed_quieres_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dealerships ALTER COLUMN id SET DEFAULT nextval('dealerships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY engines ALTER COLUMN id SET DEFAULT nextval('engines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY engines_inventories ALTER COLUMN id SET DEFAULT nextval('engines_inventories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY epa_green_score_records ALTER COLUMN id SET DEFAULT nextval('epa_green_score_records_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY epa_mpg_records ALTER COLUMN id SET DEFAULT nextval('epa_mpg_records_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY equipments ALTER COLUMN id SET DEFAULT nextval('equipments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY equipments_inventories ALTER COLUMN id SET DEFAULT nextval('equipments_inventories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fluid_levels ALTER COLUMN id SET DEFAULT nextval('fluid_levels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventories ALTER COLUMN id SET DEFAULT nextval('inventories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventories_options ALTER COLUMN id SET DEFAULT nextval('inventories_options_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventories_specifications ALTER COLUMN id SET DEFAULT nextval('inventories_specifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventories_transmissions ALTER COLUMN id SET DEFAULT nextval('inventories_transmissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY items ALTER COLUMN id SET DEFAULT nextval('items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY next_maintenance_appointments ALTER COLUMN id SET DEFAULT nextval('next_maintenance_appointments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY options ALTER COLUMN id SET DEFAULT nextval('options_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pricings ALTER COLUMN id SET DEFAULT nextval('pricings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rails_admin_histories ALTER COLUMN id SET DEFAULT nextval('rails_admin_histories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY safety_equipments ALTER COLUMN id SET DEFAULT nextval('safety_equipments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY scheduled_maintenance_items ALTER COLUMN id SET DEFAULT nextval('scheduled_maintenance_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY specifications ALTER COLUMN id SET DEFAULT nextval('specifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tire_wear_indicates ALTER COLUMN id SET DEFAULT nextval('tire_wear_indicates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transmissions ALTER COLUMN id SET DEFAULT nextval('transmissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vehicle_components ALTER COLUMN id SET DEFAULT nextval('vehicle_components_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vehicle_identification_numbers ALTER COLUMN id SET DEFAULT nextval('vehicle_identification_numbers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vehicle_report_cards ALTER COLUMN id SET DEFAULT nextval('vehicle_report_cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vehicles ALTER COLUMN id SET DEFAULT nextval('vehicles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY warranties ALTER COLUMN id SET DEFAULT nextval('warranties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wiper_blades ALTER COLUMN id SET DEFAULT nextval('wiper_blades_id_seq'::regclass);


--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: batteries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY batteries
    ADD CONSTRAINT batteries_pkey PRIMARY KEY (id);


--
-- Name: brake_wear_indicates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY brake_wear_indicates
    ADD CONSTRAINT brake_wear_indicates_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: colors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (id);


--
-- Name: data_one_error_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_one_error_messages
    ADD CONSTRAINT data_one_error_messages_pkey PRIMARY KEY (id);


--
-- Name: data_one_failed_quieres_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_one_failed_quieres
    ADD CONSTRAINT data_one_failed_quieres_pkey PRIMARY KEY (id);


--
-- Name: dealerships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dealerships
    ADD CONSTRAINT dealerships_pkey PRIMARY KEY (id);


--
-- Name: engines_inventories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY engines_inventories
    ADD CONSTRAINT engines_inventories_pkey PRIMARY KEY (id);


--
-- Name: engines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY engines
    ADD CONSTRAINT engines_pkey PRIMARY KEY (id);


--
-- Name: epa_green_score_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY epa_green_score_records
    ADD CONSTRAINT epa_green_score_records_pkey PRIMARY KEY (id);


--
-- Name: epa_mpg_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY epa_mpg_records
    ADD CONSTRAINT epa_mpg_records_pkey PRIMARY KEY (id);


--
-- Name: equipments_inventories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY equipments_inventories
    ADD CONSTRAINT equipments_inventories_pkey PRIMARY KEY (id);


--
-- Name: equipments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY equipments
    ADD CONSTRAINT equipments_pkey PRIMARY KEY (id);


--
-- Name: fluid_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fluid_levels
    ADD CONSTRAINT fluid_levels_pkey PRIMARY KEY (id);


--
-- Name: inventories_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inventories_options
    ADD CONSTRAINT inventories_options_pkey PRIMARY KEY (id);


--
-- Name: inventories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inventories
    ADD CONSTRAINT inventories_pkey PRIMARY KEY (id);


--
-- Name: inventories_specifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inventories_specifications
    ADD CONSTRAINT inventories_specifications_pkey PRIMARY KEY (id);


--
-- Name: inventories_transmissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inventories_transmissions
    ADD CONSTRAINT inventories_transmissions_pkey PRIMARY KEY (id);


--
-- Name: items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: next_maintenance_appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY next_maintenance_appointments
    ADD CONSTRAINT next_maintenance_appointments_pkey PRIMARY KEY (id);


--
-- Name: options_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- Name: pricings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pricings
    ADD CONSTRAINT pricings_pkey PRIMARY KEY (id);


--
-- Name: rails_admin_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rails_admin_histories
    ADD CONSTRAINT rails_admin_histories_pkey PRIMARY KEY (id);


--
-- Name: safety_equipments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY safety_equipments
    ADD CONSTRAINT safety_equipments_pkey PRIMARY KEY (id);


--
-- Name: scheduled_maintenance_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY scheduled_maintenance_items
    ADD CONSTRAINT scheduled_maintenance_items_pkey PRIMARY KEY (id);


--
-- Name: specifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY specifications
    ADD CONSTRAINT specifications_pkey PRIMARY KEY (id);


--
-- Name: tire_wear_indicates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tire_wear_indicates
    ADD CONSTRAINT tire_wear_indicates_pkey PRIMARY KEY (id);


--
-- Name: transmissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transmissions
    ADD CONSTRAINT transmissions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vehicle_components_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vehicle_components
    ADD CONSTRAINT vehicle_components_pkey PRIMARY KEY (id);


--
-- Name: vehicle_identification_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vehicle_identification_numbers
    ADD CONSTRAINT vehicle_identification_numbers_pkey PRIMARY KEY (id);


--
-- Name: vehicle_report_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vehicle_report_cards
    ADD CONSTRAINT vehicle_report_cards_pkey PRIMARY KEY (id);


--
-- Name: vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vehicles
    ADD CONSTRAINT vehicles_pkey PRIMARY KEY (id);


--
-- Name: warranties_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY warranties
    ADD CONSTRAINT warranties_pkey PRIMARY KEY (id);


--
-- Name: wiper_blades_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wiper_blades
    ADD CONSTRAINT wiper_blades_pkey PRIMARY KEY (id);


--
-- Name: index_authentications_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_authentications_on_deleted_at ON authentications USING btree (deleted_at);


--
-- Name: index_authentications_on_provider; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_authentications_on_provider ON authentications USING btree (provider);


--
-- Name: index_batteries_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_batteries_on_deleted_at ON batteries USING btree (deleted_at);


--
-- Name: index_batteries_on_vehicle_report_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_batteries_on_vehicle_report_card_id ON batteries USING btree (vehicle_report_card_id);


--
-- Name: index_brake_wear_indicates_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_brake_wear_indicates_on_deleted_at ON brake_wear_indicates USING btree (deleted_at);


--
-- Name: index_brake_wear_indicates_on_vehicle_report_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_brake_wear_indicates_on_vehicle_report_card_id ON brake_wear_indicates USING btree (vehicle_report_card_id);


--
-- Name: index_fluid_levels_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_fluid_levels_on_deleted_at ON fluid_levels USING btree (deleted_at);


--
-- Name: index_fluid_levels_on_vehicle_report_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_fluid_levels_on_vehicle_report_card_id ON fluid_levels USING btree (vehicle_report_card_id);


--
-- Name: index_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_items_on_deleted_at ON items USING btree (deleted_at);


--
-- Name: index_items_on_vehicle_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_items_on_vehicle_id ON items USING btree (vehicle_id);


--
-- Name: index_next_maintenance_appointments_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_next_maintenance_appointments_on_deleted_at ON next_maintenance_appointments USING btree (deleted_at);


--
-- Name: index_next_maintenance_appointments_on_vehicle_report_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_next_maintenance_appointments_on_vehicle_report_card_id ON next_maintenance_appointments USING btree (vehicle_report_card_id);


--
-- Name: index_oauth_caches_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_oauth_caches_on_deleted_at ON oauth_caches USING btree (deleted_at);


--
-- Name: index_rails_admin_histories; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rails_admin_histories ON rails_admin_histories USING btree (item, "table", month, year);


--
-- Name: index_rails_admin_histories_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rails_admin_histories_on_deleted_at ON rails_admin_histories USING btree (deleted_at);


--
-- Name: index_scheduled_maintenance_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_scheduled_maintenance_items_on_deleted_at ON scheduled_maintenance_items USING btree (deleted_at);


--
-- Name: index_scheduled_maintenance_items_on_vehicle_report_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_scheduled_maintenance_items_on_vehicle_report_card_id ON scheduled_maintenance_items USING btree (vehicle_report_card_id);


--
-- Name: index_tire_wear_indicates_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tire_wear_indicates_on_deleted_at ON tire_wear_indicates USING btree (deleted_at);


--
-- Name: index_tire_wear_indicates_on_vehicle_report_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tire_wear_indicates_on_vehicle_report_card_id ON tire_wear_indicates USING btree (vehicle_report_card_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_deleted_at ON users USING btree (deleted_at);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_invitations_count ON users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_invited_by_id ON users USING btree (invited_by_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON users USING btree (unlock_token);


--
-- Name: index_vehicle_components_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicle_components_on_deleted_at ON vehicle_components USING btree (deleted_at);


--
-- Name: index_vehicle_components_on_vehicle_report_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicle_components_on_vehicle_report_card_id ON vehicle_components USING btree (vehicle_report_card_id);


--
-- Name: index_vehicle_identification_numbers_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicle_identification_numbers_on_deleted_at ON vehicle_identification_numbers USING btree (deleted_at);


--
-- Name: index_vehicle_report_cards_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicle_report_cards_on_deleted_at ON vehicle_report_cards USING btree (deleted_at);


--
-- Name: index_vehicle_report_cards_on_model; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicle_report_cards_on_model ON vehicle_report_cards USING btree (model);


--
-- Name: index_vehicle_report_cards_on_report_card_date; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicle_report_cards_on_report_card_date ON vehicle_report_cards USING btree (report_card_date);


--
-- Name: index_vehicle_report_cards_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicle_report_cards_on_user_id ON vehicle_report_cards USING btree (user_id);


--
-- Name: index_vehicles_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicles_on_deleted_at ON vehicles USING btree (deleted_at);


--
-- Name: index_vehicles_on_vehicle_identification_number_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vehicles_on_vehicle_identification_number_id ON vehicles USING btree (vehicle_identification_number_id);


--
-- Name: index_wiper_blades_on_deleted_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wiper_blades_on_deleted_at ON wiper_blades USING btree (deleted_at);


--
-- Name: index_wiper_blades_on_vehicle_report_card_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wiper_blades_on_vehicle_report_card_id ON wiper_blades USING btree (vehicle_report_card_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_b06ccda810; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_rails_b06ccda810 FOREIGN KEY (vehicle_id) REFERENCES vehicles(id);


--
-- Name: fk_rails_d890622518; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY vehicles
    ADD CONSTRAINT fk_rails_d890622518 FOREIGN KEY (vehicle_identification_number_id) REFERENCES vehicle_identification_numbers(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130909170542');

INSERT INTO schema_migrations (version) VALUES ('20130909194719');

INSERT INTO schema_migrations (version) VALUES ('20131020063216');

INSERT INTO schema_migrations (version) VALUES ('20131021224642');

INSERT INTO schema_migrations (version) VALUES ('20140204233100');

INSERT INTO schema_migrations (version) VALUES ('20140204233952');

INSERT INTO schema_migrations (version) VALUES ('20160324153206');

INSERT INTO schema_migrations (version) VALUES ('20160325043245');

INSERT INTO schema_migrations (version) VALUES ('20160325064046');

INSERT INTO schema_migrations (version) VALUES ('20160325075956');

INSERT INTO schema_migrations (version) VALUES ('20160325080140');

INSERT INTO schema_migrations (version) VALUES ('20160325085059');

INSERT INTO schema_migrations (version) VALUES ('20160325093759');

INSERT INTO schema_migrations (version) VALUES ('20160325094659');

INSERT INTO schema_migrations (version) VALUES ('20160325180826');

INSERT INTO schema_migrations (version) VALUES ('20160325182756');

INSERT INTO schema_migrations (version) VALUES ('20160325192412');

INSERT INTO schema_migrations (version) VALUES ('20160328081355');

INSERT INTO schema_migrations (version) VALUES ('20160328125105');

INSERT INTO schema_migrations (version) VALUES ('20160330125915');

INSERT INTO schema_migrations (version) VALUES ('20160331060442');

INSERT INTO schema_migrations (version) VALUES ('20160331070209');

INSERT INTO schema_migrations (version) VALUES ('20160331074946');

INSERT INTO schema_migrations (version) VALUES ('20160331091554');

INSERT INTO schema_migrations (version) VALUES ('20160401082711');

INSERT INTO schema_migrations (version) VALUES ('20160401110719');

INSERT INTO schema_migrations (version) VALUES ('20160405102622');

INSERT INTO schema_migrations (version) VALUES ('20160407053141');

INSERT INTO schema_migrations (version) VALUES ('20160407053245');

INSERT INTO schema_migrations (version) VALUES ('20160407053312');

INSERT INTO schema_migrations (version) VALUES ('20160411121507');

INSERT INTO schema_migrations (version) VALUES ('20160411130119');

INSERT INTO schema_migrations (version) VALUES ('20160412071750');

INSERT INTO schema_migrations (version) VALUES ('20160413105210');

INSERT INTO schema_migrations (version) VALUES ('20160414054414');

INSERT INTO schema_migrations (version) VALUES ('20160414112902');

INSERT INTO schema_migrations (version) VALUES ('20160415171907');

INSERT INTO schema_migrations (version) VALUES ('20160419081059');

INSERT INTO schema_migrations (version) VALUES ('20160419145003');

INSERT INTO schema_migrations (version) VALUES ('20160424120036');

INSERT INTO schema_migrations (version) VALUES ('20160425063048');

INSERT INTO schema_migrations (version) VALUES ('20160425103413');

INSERT INTO schema_migrations (version) VALUES ('20160429120307');

INSERT INTO schema_migrations (version) VALUES ('20160511051211');

INSERT INTO schema_migrations (version) VALUES ('20160606162155');

INSERT INTO schema_migrations (version) VALUES ('20160729054610');

INSERT INTO schema_migrations (version) VALUES ('20160804102045');

INSERT INTO schema_migrations (version) VALUES ('20160811094619');

INSERT INTO schema_migrations (version) VALUES ('20160811102629');

INSERT INTO schema_migrations (version) VALUES ('20170311072741');

INSERT INTO schema_migrations (version) VALUES ('20170406182324');

