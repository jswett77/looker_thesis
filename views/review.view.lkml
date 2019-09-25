view: review {
  sql_table_name: yelp_data.Review ;;
  drill_fields: [review_id]

  dimension: review_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.review_id ;;
  }

  dimension: business_id {
    type: string
    sql: ${TABLE}.business_id ;;
  }

  dimension: cool {
    type: number
    sql: ${TABLE}.cool ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: funny {
    type: number
    sql: ${TABLE}.funny ;;
  }

  dimension: stars {
    type: number
    sql: ${TABLE}.stars ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: useful {
    type: number
    sql: ${TABLE}.useful ;;
  }

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [business_id, review_id, user.user_id, user.name]
  }

  measure: average {
    type: average
    sql: ${stars} ;;
    link: {
      label: "Show historical ratings"
      url: "/explore/justin_swett_thesis/b?fields=review.count,review.date_month,review.average&fill_fields=review.date_month&f[review.business_id]={{business_id}}&sorts=review.date_month desc&limit=500&query_timezone=America/Los_Angeles"
    }
  }
}
