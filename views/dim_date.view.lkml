view: dim_date {
  sql_table_name: public.DIM_Date ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: day {
    type: number
    sql: ${TABLE}."day" ;;
  }
  dimension: month {
    type: number
    sql: ${TABLE}."month" ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}."year" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
