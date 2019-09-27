view: reuben_reviews {
  # https://docs.looker.com/data-modeling/learning-lookml/templated-filters
  derived_table: {
    sql: SELECT
        review.review_id as review_id,
        review.text  AS review_text,
        review.business_id  AS review_business_id,
        review.stars AS stars,
        review.useful AS useful
      FROM yelp_data.Review  AS review
      WHERE
      {% if food_craving._parameter_value == 'ruben' %} @{rueben_match}
      {% elsif food_craving._parameter_value == 'ramen' %} @{ramen_match}
      {% else %}@{rueben_match} {% endif %}
      ORDER BY 1
       ;;
  }

  #(lower(review.text) LIKE '% reuben %' OR lower(review.text) LIKE '% ruben %' OR lower(review.text) LIKE '% rueben %')
  parameter: food_craving {
    type: string
    allowed_value: {
        label: "Reuben"
        value: "ruben"
    }

    allowed_value: {
      label: "Ramen"
      value: "ramen"
    }

    default_value: "Reuben"
  }

  #templated filter


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: average {
    type: average
    sql: ${stars} ;;
    link: {
      label: "Show historical ratings"
      url: "/explore/justin_swett_thesis/b?fields=review.count,review.date_month,review.average&fill_fields=review.date_month&f[review.business_id]={{review_business_id}}&sorts=review.date_month desc&limit=500&query_timezone=America/Los_Angeles"
    }
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
