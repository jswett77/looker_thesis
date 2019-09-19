view: reuben_reviews {
  derived_table: {
    sql: SELECT
        review.review_id as review_id,
        review.text  AS review_text,
        review.business_id  AS review_business_id
      FROM yelp_data.Review  AS review
      WHERE
      (lower(review.text) LIKE '% reuben %' OR lower(review.text) LIKE '% ruben %')
      ORDER BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: review_id {
    type: string
    sql: ${TABLE}.review_id ;;
    primary_key: yes
  }

  dimension: review_text {
    type: string
    sql: ${TABLE}.review_text ;;
  }

  dimension: review_business_id {
    type: string
    sql: ${TABLE}.review_business_id ;;
  }

  set: detail {
    fields: [review_text, review_business_id, review_id]
  }
}
