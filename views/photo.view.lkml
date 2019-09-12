view: photo {
  sql_table_name: yelp_data.Photo ;;
  drill_fields: [photo_id]

  dimension: photo_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.photo_id ;;
  }

  dimension: business_id {
    type: string
    sql: ${TABLE}.business_id ;;
  }

  dimension: caption {
    type: string
    sql: ${TABLE}.caption ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.label ;;
  }

  measure: count {
    type: count
    drill_fields: [photo_id]
  }
}
