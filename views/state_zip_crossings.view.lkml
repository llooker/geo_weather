view: state_zip_crossings {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: WITH multi_county as
          (SELECT
            zip_code,
            count(*)
           FROM
            ${zip_codes.SQL_TABLE_NAME} zip
          JOIN ${states.SQL_TABLE_NAME} ON ST_AREA(ST_INTERSECTION(state_geom, zip.zip_code_geom)) > 0
        GROUP BY 1
        HAVING COUNT(*) > 1)
        SELECT
          multi_county.zip_code,
          s.state_fips_code,
          ST_SIMPLIFY(ST_INTERSECTION(s.state_geom, zip.zip_code_geom), 100) as zip_county_geom
        FROM
            multi_county
            JOIN ${zip_codes.SQL_TABLE_NAME} zip USING (zip_code)
            JOIN ${states.SQL_TABLE_NAME} s ON ST_INTERSECTS(s.state_geom, zip.zip_code_geom)
      ;;
  }

  dimension: zip_code {
    type: zipcode
  }

  dimension: state {
    sql: ${TABLE}.state_fips_code ;;
  }

  dimension: zip_county_geom {
    type: string
    sql: ST_ASGEOJSON(${TABLE}.zip_county_geom) ;;
  }


}
