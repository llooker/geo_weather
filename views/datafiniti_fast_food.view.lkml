view: datafiniti_fast_food {
  sql_table_name: `mintz-hackday-61910.fast_food.fast_food_standardized`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: categories {
    type: string
    sql: ${TABLE}.categories ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: date_added {
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
    sql: ${TABLE}.dateAdded ;;
  }

  dimension_group: date_updated {
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
    sql: ${TABLE}.dateUpdated ;;
  }

  dimension: keys {
    type: string
    sql: ${TABLE}.keys ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: location {
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
    type: location
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postalCode ;;
  }

  dimension: province {
    type: string
    sql: ${TABLE}.province ;;
  }

  dimension: source_urls {
    type: string
    sql: ${TABLE}.sourceURLs ;;
  }

  dimension: websites {
    type: string
    sql: ${TABLE}.websites ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
