explore: zip_station_date_map {}
view: zip_station_date_map {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
        WITH closest_station_date AS (
          SELECT
                zip_code,
                date,
                MIN(distance) as closest_distance
              FROM
                `bigquery-public-data.noaa_gsod.gsod202*` gsod2021
                LEFT JOIN ${zip_station_map.SQL_TABLE_NAME} ON station_id=CONCAT(gsod2021.wban, gsod2021.stn)
              GROUP BY
                1, 2)
      SELECT
        zip_code,
        date,
        ARRAY_AGG(
          CASE
            WHEN closest_distance = 0
            THEN CASE WHEN distance = 0 THEN station_id ELSE NULL END
            WHEN closest_distance < 5000
            THEN CASE WHEN distance < 5000 THEN station_id ELSE NULL END
            WHEN closest_distance < 20000
            THEN CASE WHEN distance < 20000 THEN station_id ELSE NULL END
            ELSE station_id
          END IGNORE NULLS) as stations_to_include
      FROM
        ${zip_station_map.SQL_TABLE_NAME}
        LEFT JOIN closest_station_date USING (zip_code)
      GROUP BY 1,2
      ;;
      persist_for: "24 hours"
  }

  # Define your dimensions and measures here, like this:
  dimension: zip_code {
    type: zipcode
  }

  dimension: date {}

  dimension: stations {
    sql: stations_to_include ;;
  }


}

view: stations_to_include {

  dimension: station_id {
    type: string
    sql: ${TABLE} ;;
  }
}
