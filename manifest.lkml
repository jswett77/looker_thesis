project_name: "justin_swett_thesis"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

constant: rueben_match {
  value: "(lower(review.text) LIKE '% reuben %' OR lower(review.text) LIKE '% ruben %' OR lower(review.text) LIKE '% rueben %')"
}

constant: ramen_match {
  value: "(lower(review.text) LIKE '% ramen %' OR lower(review.text) LIKE '% noodle %' OR lower(review.text) LIKE '% shoyu %' OR lower(review.text) LIKE '% tonkotsu %')"
}
