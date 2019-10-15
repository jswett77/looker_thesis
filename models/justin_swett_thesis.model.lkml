connection: "op_yelp_thesis"

# include all the views
include: "/views/**/*.view"

# datagroup: justin_swett_thesis_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }

# persist_with: justin_swett_thesis_default_datagroup

explore: establishment {
  label: "Business Explore"

  join: craved_reviews {
    view_label: "Craving Specific Reviews"
    type: inner
    sql_on: ${establishment.business_id} = ${craved_reviews.review_business_id} ;;
    relationship: one_to_many
  }

  join: review {
    view_label: "All Reviews"
    type: inner
    sql_on: ${establishment.business_id} = ${review.business_id};;
    relationship: one_to_many
  }

  join: photo {
    view_label: "Photos"
    type: inner
    relationship: one_to_many
    sql_on:  ${establishment.business_id} = ${photo.business_id};;
  }

  join: user {
    view_label: "Users to Reviews"
    type: left_outer
    sql_on: ${user.user_id} = ${review.user_id} ;;
    relationship: one_to_many
  }
}

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

explore: craved_reviews { }

explore: global_consts {}
