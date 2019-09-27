connection: "op_yelp_thesis"

# include all the views
include: "/views/**/*.view"

datagroup: justin_swett_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: justin_swett_thesis_default_datagroup

explore: establishment {
  label: "Business Explore"

  join: b__hours {
    view_label: "B: Hours"
    sql: LEFT JOIN UNNEST([${establishment.hours}]) as b__hours ;;
    relationship: one_to_one
  }

  join: b__attributes {
    view_label: "B: Attributes"
    sql: LEFT JOIN UNNEST([${establishment.attributes}]) as b__attributes ;;
    relationship: one_to_one
  }

  join: review {
    view_label: "All Reviews"
    type: inner
    sql_on: ${establishment.business_id} = ${review.business_id};;
    relationship: one_to_many
  }

  join: user {
    view_label: "Users to Reviews"
    type: left_outer
    sql_on: ${user.user_id} = ${review.user_id} ;;
    relationship: one_to_many
  }

  join: reuben_reviews {
    view_label: "Ruben Reviews"
    type: inner
    sql_on: ${establishment.business_id} = ${reuben_reviews.review_business_id} ;;
    relationship: one_to_many

  }
}

explore: check_in {}

explore: photo {}

explore: review {
  join: user {
    type: left_outer
    sql_on: ${review.user_id} = ${user.user_id} ;;
    relationship: many_to_one
  }
}

explore: tip {
  join: user {
    type: left_outer
    sql_on: ${tip.user_id} = ${user.user_id} ;;
    relationship: many_to_one
  }
}

explore: user {}

explore: reuben_reviews { }
