view: states {
  sql_table_name: `bigquery-public-data.geo_us_boundaries.states`
    ;;



  dimension: area_land_meters {
    type: number
    sql: ${TABLE}.area_land_meters ;;
  }

  dimension: area_water_meters {
    type: number
    sql: ${TABLE}.area_water_meters ;;
  }

  dimension: division_code {
    type: string
    sql: ${TABLE}.division_code ;;
  }

  dimension: functional_status {
    type: string
    sql: ${TABLE}.functional_status ;;
  }

  dimension: geo_id {
    type: string
    sql: ${TABLE}.geo_id ;;
  }

  dimension: int_point_geom {
    type: string
    sql: ${TABLE}.int_point_geom ;;
  }

  dimension: int_point_lat {
    type: number
    sql: ${TABLE}.int_point_lat ;;
  }

  dimension: int_point_lon {
    type: number
    sql: ${TABLE}.int_point_lon ;;
  }

  dimension: lsad_code {
    type: string
    sql: ${TABLE}.lsad_code ;;
  }

  dimension: mtfcc_feature_class_code {
    type: string
    sql: ${TABLE}.mtfcc_feature_class_code ;;
  }

  dimension: region_code {
    type: string
    sql: ${TABLE}.region_code ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: state_fips_code {
    type: string
    sql: ${TABLE}.state_fips_code ;;
  }

  dimension: state_geom {
    type: string
    sql: ${TABLE}.state_geom ;;
  }

  dimension: state_gnis_code {
    type: string
    sql: ${TABLE}.state_gnis_code ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  measure: count {
    type: count
    drill_fields: [state_name]
  }
}
