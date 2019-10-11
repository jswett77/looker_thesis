view: establishment {
  sql_table_name: yelp_data.b ;;

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    link: {
      label: "Establishment Factsheet"
      url: "dashboards/448?Establishment%20ID={{business_id}}"
    }
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

view: b__hours {
  dimension: friday {
    type: string
    sql: ${TABLE}.Friday ;;
  }

  dimension: monday {
    type: string
    sql: ${TABLE}.Monday ;;
  }

  dimension: saturday {
    type: string
    sql: ${TABLE}.Saturday ;;
  }

  dimension: sunday {
    type: string
    sql: ${TABLE}.Sunday ;;
  }

  dimension: thursday {
    type: string
    sql: ${TABLE}.Thursday ;;
  }

  dimension: tuesday {
    type: string
    sql: ${TABLE}.Tuesday ;;
  }

  dimension: wednesday {
    type: string
    sql: ${TABLE}.Wednesday ;;
  }
}

view: b__attributes {
  dimension: accepts_insurance {
    type: yesno
    sql: ${TABLE}.AcceptsInsurance ;;
  }

  dimension: ages_allowed {
    type: string
    sql: ${TABLE}.AgesAllowed ;;
  }

  dimension: alcohol {
    type: string
    sql: ${TABLE}.Alcohol ;;
  }

  dimension: ambience {
    type: string
    sql: ${TABLE}.Ambience ;;
  }

  dimension: best_nights {
    type: string
    sql: ${TABLE}.BestNights ;;
  }

  dimension: bike_parking {
    type: string
    sql: ${TABLE}.BikeParking ;;
  }

  dimension: business_accepts_bitcoin {
    type: yesno
    sql: ${TABLE}.BusinessAcceptsBitcoin ;;
  }

  dimension: business_accepts_credit_cards {
    type: string
    sql: ${TABLE}.BusinessAcceptsCreditCards ;;
  }

  dimension: business_parking {
    type: string
    sql: ${TABLE}.BusinessParking ;;
  }

  dimension: by_appointment_only {
    type: string
    sql: ${TABLE}.ByAppointmentOnly ;;
  }

  dimension: byob {
    type: yesno
    sql: ${TABLE}.BYOB ;;
  }

  dimension: byobcorkage {
    type: string
    sql: ${TABLE}.BYOBCorkage ;;
  }

  dimension: caters {
    type: yesno
    sql: ${TABLE}.Caters ;;
  }

  dimension: coat_check {
    type: yesno
    sql: ${TABLE}.CoatCheck ;;
  }

  dimension: corkage {
    type: yesno
    sql: ${TABLE}.Corkage ;;
  }

  dimension: dogs_allowed {
    type: yesno
    sql: ${TABLE}.DogsAllowed ;;
  }

  dimension: drive_thru {
    type: yesno
    sql: ${TABLE}.DriveThru ;;
  }

  dimension: good_for_dancing {
    type: yesno
    sql: ${TABLE}.GoodForDancing ;;
  }

  dimension: good_for_kids {
    type: yesno
    sql: ${TABLE}.GoodForKids ;;
  }

  dimension: good_for_meal {
    type: string
    sql: ${TABLE}.GoodForMeal ;;
  }

  dimension: hair_specializes_in {
    type: string
    sql: ${TABLE}.HairSpecializesIn ;;
  }

  dimension: happy_hour {
    type: yesno
    sql: ${TABLE}.HappyHour ;;
  }

  dimension: has_tv {
    type: yesno
    sql: ${TABLE}.HasTV ;;
  }

  dimension: music {
    type: string
    sql: ${TABLE}.Music ;;
  }

  dimension: noise_level {
    type: string
    sql: ${TABLE}.NoiseLevel ;;
  }

  dimension: outdoor_seating {
    type: yesno
    sql: ${TABLE}.OutdoorSeating ;;
  }

  dimension: restaurants_attire {
    type: string
    sql: ${TABLE}.RestaurantsAttire ;;
  }

  dimension: restaurants_delivery {
    type: yesno
    sql: ${TABLE}.RestaurantsDelivery ;;
  }

  dimension: restaurants_good_for_groups {
    type: yesno
    sql: ${TABLE}.RestaurantsGoodForGroups ;;
  }

  dimension: restaurants_price_range2 {
    type: number
    sql: ${TABLE}.RestaurantsPriceRange2 ;;
  }

  dimension: restaurants_reservations {
    type: yesno
    sql: ${TABLE}.RestaurantsReservations ;;
  }

  dimension: restaurants_table_service {
    type: yesno
    sql: ${TABLE}.RestaurantsTableService ;;
  }

  dimension: restaurants_take_out {
    type: yesno
    sql: ${TABLE}.RestaurantsTakeOut ;;
  }

  dimension: smoking {
    type: string
    sql: ${TABLE}.Smoking ;;
  }

  dimension: wheelchair_accessible {
    type: yesno
    sql: ${TABLE}.WheelchairAccessible ;;
  }

  dimension: wi_fi {
    type: string
    sql: ${TABLE}.WiFi ;;
  }
}
