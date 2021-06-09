view: nyc_311 {
    derived_table: {
      sql: SELECT * FROM `bigquery-public-data.new_york_311.311_service_requests`  ;;
      persist_for: "24 hours"
    }


  dimension: address_type {
    type: string
    sql: ${TABLE}.address_type ;;
  }

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }

  dimension: agency_name {
    type: string
    sql: ${TABLE}.agency_name ;;
  }

  dimension: bbl {
    type: number
    sql: ${TABLE}.bbl ;;
  }

  dimension: borough {
    type: string
    sql: ${TABLE}.borough ;;
  }

  dimension: bridge_highway_direction {
    type: string
    sql: ${TABLE}.bridge_highway_direction ;;
  }

  dimension: bridge_highway_name {
    type: string
    sql: ${TABLE}.bridge_highway_name ;;
  }

  dimension: bridge_highway_segment {
    type: string
    sql: ${TABLE}.bridge_highway_segment ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension_group: closed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.closed_date ;;
  }

  dimension: community_board {
    type: string
    sql: ${TABLE}.community_board ;;
  }

  dimension: complaint_type {
    type: string
    sql: ${TABLE}.complaint_type ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_date ;;
  }

  dimension: cross_street_1 {
    type: string
    sql: ${TABLE}.cross_street_1 ;;
  }

  dimension: cross_street_2 {
    type: string
    sql: ${TABLE}.cross_street_2 ;;
  }

  dimension: descriptor {
    type: string
    sql: ${TABLE}.descriptor ;;
  }

  dimension_group: due {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.due_date ;;
  }

  dimension: facility_type {
    type: string
    sql: ${TABLE}.facility_type ;;
  }

  dimension: incident_address {
    type: string
    sql: ${TABLE}.incident_address ;;
  }

  dimension: incident_zip {
    type: string
    sql: ${TABLE}.incident_zip ;;
  }

  dimension: intersection_street_1 {
    type: string
    sql: ${TABLE}.intersection_street_1 ;;
  }

  dimension: intersection_street_2 {
    type: string
    sql: ${TABLE}.intersection_street_2 ;;
  }

  dimension: landmark {
    type: string
    sql: ${TABLE}.landmark ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: location_type {
    type: string
    sql: ${TABLE}.location_type ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: open_data_channel_type {
    type: string
    sql: ${TABLE}.open_data_channel_type ;;
  }

  dimension: park_borough {
    type: string
    sql: ${TABLE}.park_borough ;;
  }

  dimension: park_facility_name {
    type: string
    sql: ${TABLE}.park_facility_name ;;
  }

  dimension_group: resolution_action_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.resolution_action_updated_date ;;
  }

  dimension: resolution_description {
    type: string
    sql: ${TABLE}.resolution_description ;;
  }

  dimension: road_ramp {
    type: string
    sql: ${TABLE}.road_ramp ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: street_name {
    type: string
    sql: ${TABLE}.street_name ;;
  }

  dimension: taxi_company_borough {
    type: string
    sql: ${TABLE}.taxi_company_borough ;;
  }

  dimension: taxi_pickup_location {
    type: string
    sql: ${TABLE}.taxi_pickup_location ;;
  }

  dimension: unique_key {
    type: number
    sql: ${TABLE}.unique_key ;;
  }

  dimension: vehicle_type {
    type: string
    sql: ${TABLE}.vehicle_type ;;
  }

  dimension: x_coordinate {
    type: number
    sql: ${TABLE}.x_coordinate ;;
  }

  dimension: y_coordinate {
    type: number
    sql: ${TABLE}.y_coordinate ;;
  }

  measure: count {
    type: count
    drill_fields: [street_name, bridge_highway_name, park_facility_name, agency_name]
  }
}
