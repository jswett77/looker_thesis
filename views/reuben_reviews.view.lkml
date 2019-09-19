view: reuben_reviews {
  derived_table: {
    sql: SELECT
        review.review_id as review_id,
        review.text  AS review_text,
        review.business_id  AS review_business_id,
        review.stars AS stars,
        review.useful AS useful
      FROM yelp_data.Review  AS review
      WHERE
      (lower(review.text) LIKE '% reuben %' OR lower(review.text) LIKE '% ruben %' OR lower(review.text) LIKE '% rueben %')
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

  dimension: stars {
    type: number
    sql: ${TABLE}.stars ;;
  }

  dimension: useful {
    type: number
    sql: ${TABLE}.useful ;;
  }

  set: detail {
    fields: [review_text, review_business_id, review_id]
  }
}
