view: craved_reviews {
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
      {% elsif food_craving._parameter_value == "ramen" %} @{ramen_match}
      {% elsif food_craving._parameter_value == "lasagna" %}
        (lower(review.text) LIKE '% lasagna %' OR lower(review.text) LIKE '% lasagne %' OR lower(review.text) LIKE '% lasagye %')
      {% else %} true --pull in all reviews
        {% endif %}
      ORDER BY 1
       ;;
  }

  #(lower(review.text) LIKE '% reuben %' OR lower(review.text) LIKE '% ruben %' OR lower(review.text) LIKE '% rueben %')
  # liquid comments
  # -- {{ food_craving._parameter_value }}
  parameter: food_craving {
    type: unquoted

    allowed_value: {
      label: "Unspecified"
      value: "all"
    }

    allowed_value: {
        label: "Reuben"
        value: "ruben"
    }

    allowed_value: {
      label: "Ramen"
      value: "ramen"
    }

    allowed_value: {
      label: "Lasagna"
      value: "lasagna"
    }

    default_value: "all"
  }

  #templated filter
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
}
