view: zip_station_map {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
        zip_code,
        CONCAT(wban, usaf) as station_id,
        ST_DISTANCE(ST_GEOGPOINT(lon, lat), zip_code_geom) as distance
      FROM `bigquery-public-data.geo_us_boundaries.zip_codes`
      CROSS JOIN `bigquery-public-data.noaa_gsod.stations`
      WHERE LEFT(`end`, 4) > '2010' and country = 'US' AND ST_DISTANCE(ST_GEOGPOINT(lon, lat), zip_code_geom) < 100000
      ;;
      persist_for: "24 hours"
  }

  # Define your dimensions and measures here, like this:
  dimension: zip_code {
    sql: ${TABLE}.zip_code ;;
    hidden: yes
    primary_key: yes
  }

  dimension: station_id {
    sql: ${TABLE}.station_id ;;
    hidden: yes
  }

  dimension: distance {
    type: number
  }

}
