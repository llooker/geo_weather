connection: "lookerdata"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: weather_by_zip {
  from: zip_codes
  join: zip_station_date_map {
    relationship: one_to_many
    sql_on: ${weather_by_zip.zip_code} = ${zip_station_date_map.zip_code} ;;
  }

  join: stations_to_include {
    sql: LEFT JOIN UNNEST(stations_to_include) as sti ;;
    relationship: one_to_many
    required_joins: [zip_station_date_map]
  }

  join: gsod2020 {
    sql_on: sti =  ${gsod2020.station_id} AND ${gsod2020.date_date} = ${zip_station_date_map.date} ;;
    relationship: one_to_one
    required_joins: [stations_to_include]
  }
}

explore: lightning_2020 {}


#explore: datafiniti_fast_food {}

explore: nyc_311 {}

explore: state_zip_crossings {
  join: zip_codes {
    relationship: many_to_one
    sql_on: ${state_zip_crossings.zip_code}=${zip_codes.zip_code} ;;
  }

  join: states {
    relationship: many_to_one
    sql_on: ${states.state_fips_code} = ${state_zip_crossings.state} ;;
  }
}
