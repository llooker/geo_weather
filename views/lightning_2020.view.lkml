view: lightning_2020 {
  sql_table_name: `bigquery-public-data.noaa_lightning.lightning_2020`
    ;;


  dimension: center_point_geom {
    type: location
    description: "Center point of 0.10-degree tiles (roughly 1.1km) that aggregate strikes within the given tile."
    sql_longitude: ST_X(${TABLE}.center_point_geom) ;;
    sql_latitude: ST_Y(${TABLE}.center_point_geom) ;;
  }



  dimension_group: date {
    type: time
    description: "Date of the lightning strikes"
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: number_of_strikes {
    type: number
    description: "Aggregated number of lightning strikes that occured within the given tile per day"
    sql: ${TABLE}.number_of_strikes ;;
  }

  measure: strikes {
    type: sum
    sql: ${number_of_strikes} ;;
  }


}
