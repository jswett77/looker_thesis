connection: "lookerdata_publicdata_standard_sql"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: us_cities_transformed {
}


view: us_cities_transformed {
  derived_table: {
    sql:
    SELECT
          name,
          int_point_lat,
          int_point_lon,
          ST_ASTEXT(city_geom) as city_geom
        FROM
          `bigquery-public-data.utility_us.us_cities_area` ;;
  }

  dimension: name {}
  dimension: lat {
    type: number
  }
  dimension: lon {
    type:  number
  }
  dimension: city_geom { }

}
