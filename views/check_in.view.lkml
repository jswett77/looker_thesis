view: check_in {
  sql_table_name: yelp_data.Check_in ;;

  dimension: business_id {
    type: string
    sql: ${TABLE}.business_id ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
