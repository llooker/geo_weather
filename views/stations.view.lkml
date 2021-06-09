view: stations {
  sql_table_name: `bigquery-public-data.noaa_gsod.stations`
    ;;

  dimension_group: begin {
    sql: PARSE_TIMESTAMP('%Y%m%d', ${TABLE}.begin) ;;
    type: time
    timeframes: [date, month, year]
    convert_tz: no
  }

  dimension: call {
    type: string
    sql: ${TABLE}.call ;;
    hidden: yes
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: elevation {
    type: string
    sql: ${TABLE}.elev ;;
  }

  dimension_group: end {
    sql: PARSE_TIMESTAMP('%Y%m%d', ${TABLE}.`end`) ;;
    type: time
    timeframes: [date, month, year]
    convert_tz: no
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: lon {
    type: number
    sql: ${TABLE}.lon ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: station_id {
    sql: CONCAT(${wban}, ${usaf}) ;;
    primary_key: yes
  }

  dimension: usaf {
    type: string
    sql: ${TABLE}.usaf ;;
    hidden: yes
  }

  dimension: wban {
    type: string
    sql: ${TABLE}.wban ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
