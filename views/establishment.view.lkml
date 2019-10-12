view: establishment {
  sql_table_name: yelp_data.b ;;

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    link: {
      label: "Establishment Factsheet"
      url: "https://productday.dev.looker.com/dashboards/448?Establishment%20ID={{business_id}}"
    }
  }



  dimension: establishment_type {
    type: string
    case: {
      when: {
        label: "Dining"
        sql:  ${categories} like "%Restaurants%" or ${categories} like "%Food%";;
      }
      when: {
        label: "Salons"
        sql:  ${categories} like "%Salons%" or ${categories} like "%Spas%";;
      }
      when: {
        label: "Religious"
        sql:  ${categories} like "%Religious%" or ${categories} like "%Churches%";;
      }
      when: {
        label: "Nightlife"
        sql:  ${categories} like "%Bars%" or ${categories} like "%Nightlife%";;
      }
      when: {
        label: "Services"
        sql: ${categories} like "%Services *%"  ;;
      }
      when: {
        label: "Automotive"
        sql: ${categories} like "%Automotive%"  ;;
      }
      when: {
        label: "Medical"
        sql:  ${categories} like "%Medical%"  ;;
      }
      when: {
        label: "Medical"
        sql:  ${categories} like "%Medical%"  ;;
      }

      when: {
        label: "Hotel"
        sql:  ${categories} like "%Hotels%"  ;;
      }

      when: {
        label: "Eductational"
        sql: ${categories} like "%Education%" or ${categories} like "%School%" ;;
      }

      when: {
        label: "Parks and Rec"
        sql: ${categories} like "%Parks%" or ${categories} like "%Active Life%" ;;
      }

      when: {
        label: "Fitness"
        sql: ${categories} like "%Fitness%" ;;
      }

      when: {
        label: "Financial"
        sql: ${categories} like "%Financial%" ;;
      }

      when: {
        label: "Real Estate"
        sql: ${categories} like "%Real Estate%" ;;
      }

      when: {
        label: "Home Improvement"
        sql: ${categories} like "%Home & Garden%" ;;
      }

      when: {
        label: "Pet Care"
        sql: ${categories} like "%Pets%" ;;
      }

      when: {
        label: "Media Source"
        sql: ${categories} like "%Media%" ;;
      }

      when: {
        label: "Entertainment"
        sql: ${categories} like '%Entertainment%';;
      }

      when: {
        label: "Shopping"
        sql: ${categories} like '%Shopping%';;
      }
      else: "¯\_(ツ)_/¯"

    }
    alpha_sort: yes
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: attributes {
    hidden: yes
    sql: ${TABLE}.attributes ;;
  }

  dimension: business_id {
    type: string
    sql: ${TABLE}.business_id ;;
  }

  dimension: categories {
    type: string
    sql: ${TABLE}.categories ;;
  }

  filter: RestaurantsOnly {
    hidden: no
    sql: ${categories} LIKE '%Restaurants%' ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: hours {
    hidden: yes
    sql: ${TABLE}.hours ;;
  }

  dimension: is_open {
    type: number
    sql: ${TABLE}.is_open ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: location {
    type: location
    sql_latitude:${latitude} ;;
    sql_longitude:${longitude} ;;

  }

  parameter: city_param {
    label: "Visiting City"
    view_label: "Visiting City"
    type: string
    allowed_value: {
      label: "Las Vegas, NV"
      value: "vegas"
    }
    allowed_value: {
      label: "Phoenix, AZ"
      value: "phoenix"
    }
    allowed_value: {
      label: "Glendale, AZ"
      value: "glendale"
    }
    allowed_value: {
      label: "Scottsdale, AZ"
      value: "scottsdale"
    }
    allowed_value: {
      label: "Madison, WI"
      value: "madison"
    }
    allowed_value: {
      label: "Cleveland, OH"
      value: "cleveland"
    }
    allowed_value: {
      label: "Pittsburgh, PA"
      value: "pittsburgh"
    }
    allowed_value: {
      label: "Charlotte, NC"
      value: "charlotte"
    }
  }

  dimension: default_city_for_state {
    type: string
    sql: CASE WHEN ${state} = 'NV' THEN "vegas"
          WHEN ${state} = 'AZ' THEN "phoenix"
          WHEN ${state} = 'WI' THEN "madison"
          WHEN ${state} = 'OH' THEN "cleveland"
          WHEN ${state} = 'PA' THEN "pittsburgh"
          WHEN ${state} = 'NC' THEN "charlotte"
              ELSE "UNAVAILABLE" END ;;

    link: {
      label: "Establishment Factsheet"
      url: "https://productday.dev.looker.com/dashboards/447?Visiting%20City={{default_city_for_state}}"

    }
  }

  dimension: distance_city_lat {
    hidden: yes
    type: number
    sql: CASE WHEN {% parameter city_param %} = 'vegas' THEN 36.1699412
              WHEN {% parameter city_param %} = 'phoenix' THEN  33.4483771
              WHEN {% parameter city_param %} = 'glendale' THEN 33.5386523
              WHEN {% parameter city_param %} = 'scottsdale' THEN 33.4941704
              WHEN {% parameter city_param %} = 'madison' THEN 43.0730517
              WHEN {% parameter city_param %} = 'cleveland' THEN 41.49932
              WHEN {% parameter city_param %} = 'pittsburgh' THEN 40.4406248
              WHEN {% parameter city_param %} = 'charlotte' THEN  35.2270869
              ELSE 36.1699412 END ;;
  }

  dimension: distance_city_long {
    hidden: yes
    type: number
    sql: CASE WHEN {% parameter city_param %} = 'vegas' THEN -115.1398296
              WHEN {% parameter city_param %} = 'phoenix' THEN -112.0740373
              WHEN {% parameter city_param %} = 'glendale' THEN -112.1859866
              WHEN {% parameter city_param %} = 'scottsdale' THEN -111.9260519
              WHEN {% parameter city_param %} = 'madison' THEN -89.4012302
              WHEN {% parameter city_param %} = 'cleveland' THEN  -81.6943605
              WHEN {% parameter city_param %} = 'pittsburgh' THEN -79.9958864
              WHEN {% parameter city_param %} = 'charlotte' THEN -80.8431267
              ELSE -115.1398296 END ;;
  }


  dimension: location_of_selected_city {
    hidden: yes
    type: location
    sql_latitude: ${distance_city_lat} ;;
    sql_longitude: ${distance_city_long} ;;
  }

  dimension: distance_between_selected_city_and_user {
    label: "Distance in mi"
    type: distance
    start_location_field: location
    end_location_field: location_of_selected_city
    units: miles
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
    map_layer_name: "us_zipcode_tabulation_areas"
  }

  dimension: review_count {
    type: number
    sql: ${TABLE}.review_count ;;
  }

  dimension: stars {
    type: number
    sql: ${TABLE}.stars ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: "us_states"
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
