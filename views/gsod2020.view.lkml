view: gsod2020 {
  derived_table: {
    sql: WITH dupes as (
            SELECT
              *,
              row_number() OVER (PARTITION BY CASE WHEN gsod2020.wban != '99999' THEN gsod2020.wban ELSE gsod2020.stn END, `date`) as row_n
            FROM `bigquery-public-data.noaa_gsod.gsod202*` as gsod2020
            WHERE temp > -100 AND temp < 200)
          SELECT
            dupes.* EXCEPT(row_n)
          FROM dupes
          WHERE row_n = 1
    ;;
    persist_for: "24 hours"
  }

  dimension: count_dewp {
    type: number
    description: "Number of observations used in calculating mean dew point"
    sql: ${TABLE}.count_dewp ;;
  }

  dimension: count_slp {
    type: number
    description: "Number of observations used in calculating mean sea level pressure"
    sql: ${TABLE}.count_slp ;;
  }

  dimension: count_stp {
    type: number
    description: "Number of observations used in calculating mean station pressure"
    sql: ${TABLE}.count_stp ;;
  }

  dimension: count_temp {
    type: number
    description: "Number of observations used in calculating mean temperature"
    sql: ${TABLE}.count_temp ;;
  }

  dimension: count_visib {
    type: number
    description: "Number of observations used in calculating mean visibility"
    sql: ${TABLE}.count_visib ;;
  }

  dimension: count_wdsp {
    type: string
    description: "Number of observations used in calculating mean wind speed"
    sql: ${TABLE}.count_wdsp ;;
  }

  dimension: pk {
    hidden: yes
    sql: CONCAT(${station_id}, ${date_date}) ;;
    primary_key: yes
  }

  dimension_group: date {
    type: time
    description: "Date of the weather observations"
    timeframes: [
      time,
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

  dimension: dewp {
    type: number
    description: "Mean dew point for the day in degreesm Fahrenheit to tenths.  Missing = 9999.9"
    sql: ${TABLE}.dewp ;;
  }

  dimension: flag_max {
    type: string
    description: "Blank indicates max temp was taken from the explicit max temp report and not from the 'hourly' data. * indicates max temp was  derived from the hourly data (i.e., highest hourly or synoptic-reported temperature)"
    sql: ${TABLE}.flag_max ;;
  }

  dimension: flag_min {
    type: string
    description: "Blank indicates min temp was taken from the explicit min temp report and not from the 'hourly' data. * indicates min temp was derived from the hourly data (i.e., lowest hourly or synoptic-reported temperature)"
    sql: ${TABLE}.flag_min ;;
  }

  dimension: flag_prcp {
    type: string
    description: "A = 1 report of 6-hour precipitation amount B = Summation of 2 reports of 6-hour precipitation amount C = Summation of 3 reports of 6-hour precipitation amount D = Summation of 4 reports of 6-hour precipitation amount E = 1 report of 12-hour precipitation amount F = Summation of 2 reports of 12-hour precipitation amount G = 1 report of 24-hour precipitation amount H = Station reported '0' as the amount for the day (eg, from 6-hour reports), but also reported at least one occurrence of precipitation in hourly observations--this could indicate a trace occurred, but should be considered as incomplete data for the day. I = Station did not report any precip data for the day and did not report any occurrences of precipitation in its hourly observations--it's still possible that precip occurred but was not reported"
    sql: ${TABLE}.flag_prcp ;;
  }

  dimension: fog {
    type: string
    description: "Indicators (1 = yes, 0 = no/not reported) for the occurrence during the day"
    sql: ${TABLE}.fog ;;
  }

  dimension: gust {
    type: number
    description: "Maximum wind gust reported for the day in knots to tenths. Missing = 999.9"
    sql: ${TABLE}.gust ;;
  }

  dimension: hail {
    type: string
    description: "Indicators (1 = yes, 0 = no/not reported) for the occurrence during the day"
    sql: ${TABLE}.hail ;;
  }

  dimension: max {
    type: number
    description: "Maximum temperature reported during the day in Fahrenheit to tenths--time of max temp report varies by country and region, so this will sometimes not be the max for the calendar day. Missing = 9999.9"
    sql: ${TABLE}.max ;;
  }

  measure: max_temp {
    type: average
    sql: ${max} ;;
  }

  dimension: min {
    type: number
    description: "Minimum temperature reported during the day in Fahrenheit to tenths--time of min temp report varies by country and region, so this will sometimes not be the min for the calendar day. Missing = 9999.9"
    sql: ${TABLE}.min ;;
  }

  measure: min_temp {
    type: average
    sql: ${min} ;;
  }

  dimension: mxpsd {
    type: string
    description: "Maximum sustained wind speed reported for the day in knots to tenths. Missing = 999.9"
    sql: ${TABLE}.mxpsd ;;
  }

  dimension: prcp {
    type: number
    description: "Total precipitation (rain and/or melted snow) reported during the day in inches and hundredths; will usually not end with the midnight observation--i.e., may include latter part of previous day.  .00 indicates no measurable precipitation (includes a trace). Missing = 99.99 Note: Many stations do not report '0' on days with no precipitation--therefore, '99.99' will often appear on these days. Also, for example, a station may only report a 6-hour amount for the period during which rain fell. See Flag field for source of data"
    sql: CASE WHEN ${TABLE}.prcp != 99.99 THEN ${TABLE}.prcp ELSE NULL END ;;
  }

  measure: total_precipitation {
    type: average
    sql: ${prcp} ;;
  }

  dimension: rain_drizzle {
    type: string
    description: "Indicators (1 = yes, 0 = no/not reported) for the occurrence during the day"
    sql: ${TABLE}.rain_drizzle ;;
  }

  dimension: slp {
    type: number
    description: "Mean sea level pressure for the day in millibars to tenths. Missing = 9999.9"
    sql: ${TABLE}.slp ;;
  }

  dimension: sndp {
    type: number
    description: "Snow depth in inches to tenths--last report for the day if reported more thanonce. Missing = 999.9 Note: Most stations do not report '0' ondays with no snow on the ground--therefore, '999.9' will often appear on these days"
    sql: ${TABLE}.sndp ;;
  }

  dimension: snow_ice_pellets {
    type: string
    description: "Indicators (1 = yes, 0 = no/not reported) for the occurrence during the day"
    sql: ${TABLE}.snow_ice_pellets ;;
  }

  dimension: stn {
    type: string
    description: "Cloud - GSOD NOAA"
    sql: ${TABLE}.stn ;;
  }

  dimension: station_id {
    sql: CONCAT(${wban}, ${stn}) ;;
  }

  dimension: stp {
    type: number
    description: "Mean station pressure for the day in millibars to tenths. Missing = 9999.9"
    sql: ${TABLE}.stp ;;
  }

  dimension: temp {
    type: number
    description: "Mean temperature for the day in degrees Fahrenheit to tenths. Missing = 9999.9"
    sql: ${TABLE}.temp ;;
  }

  measure: average_temp {
    type: average
    sql: ${temp} ;;
  }

  dimension: thunder {
    type: string
    description: "Indicators (1 = yes, 0 = no/not reported) for the occurrence during the day"
    sql: ${TABLE}.thunder ;;
  }

  dimension: tornado_funnel_cloud {
    type: string
    description: "Indicators (1 = yes, 0 = no/not reported) for the occurrence during the day"
    sql: ${TABLE}.tornado_funnel_cloud ;;
  }

  dimension: visib {
    type: number
    description: "Mean visibility for the day in miles to tenths.  Missing = 999.9"
    sql: ${TABLE}.visib ;;
  }

  dimension: wban {
    type: string
    description: "WBAN number where applicable--this is the historical \"Weather Bureau Air Force Navy\" number - with WBAN being the acronym"
    sql: ${TABLE}.wban ;;
  }

  dimension: wdsp {
    type: string
    description: "Mean wind speed for the day in knots to tenths. Missing = 999.9"
    sql: ${TABLE}.wdsp ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
