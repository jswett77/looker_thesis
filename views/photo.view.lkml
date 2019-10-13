view: photo {
  sql_table_name: yelp_data.Photo ;;
  drill_fields: [photo_id]

  dimension: photo_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.photo_id ;;
    link: {
      label: "{{caption}}"
      url: "https://s3-media3.fl.yelpcdn.com/bphoto/{{photo_id}}/l.jpg"
    }
    #https://s3-media3.fl.yelpcdn.com/bphoto/dsebryOjSyy9gwMWo5umjw/l.jpg
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
