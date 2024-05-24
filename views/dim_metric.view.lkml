view: dim_metric {
  sql_table_name: public.DIM_Metric ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: threshold {
    type: number
    sql: ${TABLE}."threshold" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
