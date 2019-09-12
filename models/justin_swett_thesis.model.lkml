connection: "op_yelp_thesis"

# include all the views
include: "/views/**/*.view"

datagroup: justin_swett_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: justin_swett_thesis_default_datagroup

explore: b {
  join: b__hours {
    view_label: "B: Hours"
    sql: LEFT JOIN UNNEST([${b.hours}]) as b__hours ;;
    relationship: one_to_one
  }

  join: b__attributes {
    view_label: "B: Attributes"
    sql: LEFT JOIN UNNEST([${b.attributes}]) as b__attributes ;;
    relationship: one_to_one
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
