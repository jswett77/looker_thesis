view: global_consts {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT AVG(stars) G_AVERAGE, STDDEV(stars) G_STDDEV FROM `ardent-kite-243923.yelp_data.Review` ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: G_AVERAGE {
    description: "Global Average Across Yelp"
    type: number
    sql: ${TABLE}.G_AVERAGE ;;
  }

  dimension: G_STDDEV {
    description: "STDDEV Across Yelp"
    type: number
    sql: ${TABLE}.G_STDDEV ;;
  }

}
